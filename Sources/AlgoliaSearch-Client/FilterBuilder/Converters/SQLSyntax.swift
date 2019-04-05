//
//  SQLSyntax.swift
//  AlgoliaSearch
//
//  Created by Vladislav Fitc on 05/04/2019.
//  Copyright © 2019 Algolia. All rights reserved.
//

import Foundation

protocol SQLSyntaxConvertible {
  var sqlForm: String { get }
}

class SQLFilterGroupConverter {
  
  func convert(_ filterGroups: [FilterGroup]) -> String {
    return ""
  }
  
}

class SQLFilterConverter: FilterConverter {
  
  typealias Output = String
  
  func convert(_ filter: FilterType) -> String {
    switch filter {
    case let facetFilter as Filter.Facet:
      return facetFilter.sqlForm
      
    case let numericFilter as Filter.Numeric:
      return numericFilter.sqlForm
      
    case let tagFilter as Filter.Tag:
      return tagFilter.sqlForm
      
    default:
      return ""
    }
  }
  
}

extension Filter.Numeric: SQLSyntaxConvertible {
  
  public var sqlForm: String {
    let expression: String
    switch value {
    case .comparison(let `operator`, let value):
      expression = """
      "\(attribute)" \(`operator`.rawValue) \(value)
      """
      
    case .range(let range):
      expression = """
      "\(attribute)":\(range.lowerBound) TO \(range.upperBound)
      """
    }
    let prefix = isNegated ? "NOT " : ""
    return prefix + expression
  }
  
}


extension Filter.Facet: SQLSyntaxConvertible {
  
  public var sqlForm: String {
    let scoreExpression = score.flatMap { "<score=\(String($0))>" } ?? ""
    let expression = """
    "\(attribute)":"\(value)\(scoreExpression)"
    """
    let prefix = isNegated ? "NOT " : ""
    return prefix + expression
  }
  
}

extension Filter.Tag: SQLSyntaxConvertible {
  
  public var sqlForm: String {
    let expression = """
    "\(attribute)":"\(value)"
    """
    let prefix = isNegated ? "NOT " : ""
    return prefix + expression
  }
  
}

extension AndFilterGroup: SQLSyntaxConvertible {
  
  public var sqlForm: String {
    return ""
  }
  
}

extension OrFilterGroup: SQLSyntaxConvertible {
  
  public var sqlForm: String {
    return ""
  }
  
}


