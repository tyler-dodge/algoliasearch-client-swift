//
//  AndFilterGroup.swift
//  AlgoliaSearch OSX
//
//  Created by Vladislav Fitc on 14/01/2019.
//  Copyright © 2019 Algolia. All rights reserved.
//

import Foundation

/// Representation of conjunctive group of filters

public struct AndFilterGroup: FilterGroup {
  
  public var filters: [FilterType]
  
  public var isEmpty: Bool {
    return filters.isEmpty
  }
  
  public init(filters: [FilterType]) {
      self.filters = filters
  }
  
  public static func and(_ filters: [FilterType]) -> AndFilterGroup {
      return AndFilterGroup(filters: filters)
  }

  public var description: String {
    let filtersDescription = ""
    
    switch filters.count {
    case 0:
      return ""
      
    case 1:
      return filtersDescription
      
    default:
      return "( \(filtersDescription) )"
    }
    
  }
    
}
