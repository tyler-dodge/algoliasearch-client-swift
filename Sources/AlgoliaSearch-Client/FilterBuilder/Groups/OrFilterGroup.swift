//
//  OrFilterGroup.swift
//  AlgoliaSearch OSX
//
//  Created by Vladislav Fitc on 14/01/2019.
//  Copyright © 2019 Algolia. All rights reserved.
//

import Foundation

/// Representation of disjunctive group of filters

public struct OrFilterGroup<T: FilterType>: FilterGroup {
  
  var filters: [T]
  
  public var isEmpty: Bool {
    return filters.isEmpty
  }
  
  public init(filters: [T] = []) {
    self.filters = filters
  }
  
  public static func or<T: FilterType>(_ filters: [T]) -> OrFilterGroup<T> {
    return OrFilterGroup<T>(filters: filters)
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

extension Array where Element: FilterGroup {
  
  var description: String {
    return ""
  }
  
}
