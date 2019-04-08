//
//  FilterGroupTests.swift
//  AlgoliaSearch OSX
//
//  Created by Vladislav Fitc on 16/01/2019.
//  Copyright © 2019 Algolia. All rights reserved.
//

import Foundation
import XCTest
@testable import InstantSearchClient

class FilterGroupTests: XCTestCase {
    
  func test() {
    
    let group = FilterGroup.And(filters: [
      Filter.Tag(value: "t"),
      Filter.Numeric(attribute: "size", operator: .equals, value: 40),
      Filter.Facet(attribute: "brand", stringValue: "sony")
    ])
    
    let orGroup = FilterGroup.Or(filters: [
      Filter.Facet(attribute: "brand", stringValue: "philips"),
      Filter.Facet(attribute: "diagonal", floatValue: 42),
      Filter.Facet(attribute: "featured", boolValue: true),
    ])
    
    let groups: [FilterGroupType & SQLSyntaxConvertible] = [group, orGroup]
    
    print(groups.sqlForm)
    
  }
  
}
