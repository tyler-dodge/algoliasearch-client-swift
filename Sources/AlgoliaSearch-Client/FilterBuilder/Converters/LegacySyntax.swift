//
//  LegacySyntax.swift
//  AlgoliaSearch
//
//  Created by Vladislav Fitc on 05/04/2019.
//  Copyright © 2019 Algolia. All rights reserved.
//

import Foundation

protocol LegacySyntaxConvertible {
  var legacyForm: [String] { get }
}

class LegacyFilterConverter: FilterConverter {
  
  typealias Output = [String]
  
  func convert(_ filter: FilterType) -> [String] {
    switch filter {
    case let facetFilter as Filter.Facet:
      return facetFilter.legacyForm
      
    case let numericFilter as Filter.Numeric:
      return numericFilter.legacyForm
      
    case let tagFilter as Filter.Tag:
      return tagFilter.legacyForm
      
    default:
      return []
    }
  }
  
}

extension Filter.Numeric: LegacySyntaxConvertible {
  
  public var legacyForm: [String] {
    
    let expressions: [String]
    
    switch value {
    case .comparison(let `operator`, let value):
      let `operator` = isNegated ? `operator`.inversion : `operator`
      expressions = ["""
        "\(attribute)" \(`operator`.rawValue) \(value)
        """]
      
    case .range(let range):
      expressions = [
        Filter.Numeric(attribute: attribute, operator: isNegated ? .lessThan : .greaterThanOrEqual, value: range.lowerBound),
        Filter.Numeric(attribute: attribute, operator: isNegated ? .greaterThan : .lessThanOrEqual, value: range.upperBound)
        ].flatMap { $0.legacyForm }
    }
    
    return expressions
    
  }
  
}


extension Filter.Facet: LegacySyntaxConvertible {
  
  public var legacyForm: [String] {
    let scoreExpression = score.flatMap { "<score=\(String($0))>" } ?? ""
    let valuePrefix = isNegated ? "-" : ""
    return ["""
      "\(attribute)":\(valuePrefix)"\(value)\(scoreExpression)"
      """]
  }
  
}

extension Filter.Tag: LegacySyntaxConvertible {
  
  public var legacyForm: [String] {
    let valuePrefix = isNegated ? "-" : ""
    return ["""
      "\(attribute)":\(valuePrefix)"\(value)"
      """]
  }
  
}

extension AndFilterGroup {
  
  var legacyForm: [[String]] {
    return []
  }
  
}

extension OrFilterGroup {
  
  var legacyForm: [[String]] {
    return []
  }
  
}
