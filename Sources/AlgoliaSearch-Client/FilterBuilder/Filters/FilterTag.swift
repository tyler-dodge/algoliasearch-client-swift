//
//  FilterTag.swift
//  AlgoliaSearch OSX
//
//  Created by Vladislav Fitc on 27/12/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation

/** Defines tag filter
 # See also:
 [Reference](https:www.algolia.com/doc/guides/managing-results/refine-results/filtering/how-to/filter-by-tags/)
*/


public extension Filter {
  
  struct Tag: FilterType {
    
    public let attribute: Attribute = .tags
    public var isNegated: Bool
    public let value: String
    
    public init(value: String, isNegated: Bool = false) {
      self.isNegated = isNegated
      self.value = value
    }
    
  }
  
}

extension Filter.Tag: ExpressibleByStringLiteral {
  
  public typealias StringLiteralType = String

  public init(stringLiteral string: String) {
    self.init(value: string, isNegated: false)
  }

}
