//
//  OptionalFilterBuilder.swift
//  AlgoliaSearch OSX
//
//  Created by Vladislav Fitc on 27/12/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation

public class OptionalFilterBuilder {

    let facetFilterBuilder: SpecializedFilterBuilder<FilterFacet>
    
    var isEmpty: Bool {
        return facetFilterBuilder.isEmpty
    }
    
    public init() {
        facetFilterBuilder = SpecializedFilterBuilder<FilterFacet>()
    }
    
    public subscript(group: AndFilterGroup) -> SpecializedAndGroupProxy<FilterFacet> {
        return facetFilterBuilder[group]
    }
    
    public subscript(group: OrFilterGroup<FilterFacet>) -> OrGroupProxy<FilterFacet> {
        return facetFilterBuilder[group]
    }
    
    public func build() -> [Any] {
        var result: [Any] = []
        
        facetFilterBuilder.groups.keys.sorted {
            $0.name != $1.name ? $0.name < $1.name : $0.isConjunctive
        }.forEach { group in
            let filtersExpressionForGroup = (facetFilterBuilder.groups[group] ?? [])
                .sorted { $0.expression < $1.expression }
                .map { $0.build(ignoringInversion: true) }
            if group.isConjunctive || filtersExpressionForGroup.count == 1 {
                result.append(contentsOf: filtersExpressionForGroup)
            } else {
                result.append(filtersExpressionForGroup)
            }
        }
        
        return result
    }
    
}
