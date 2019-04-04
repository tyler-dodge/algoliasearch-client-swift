//
//  Filter.swift
//  AlgoliaSearch
//
//  Created by Guy Daher on 07/12/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation

public enum Filter {}

/// Abstract filter protocol
public protocol FilterType: CustomStringConvertible {

    /// Identifier of field affected by filter
    var attribute: Attribute { get }
    
    /// A Boolean value indicating whether filter is inverted
    var isNegated: Bool { get set }
    
    /// Replaces isNegated property by a new value
    /// parameter value: new value of isNegated
    mutating func not(value: Bool)
    
}

/**
 As Filter protocol inherits Hashable protocol, it cannot be used as a type, but only as a type constraint.
 For the purpose of workaround it, a type-erased wrapper AnyFilter is introduced.
 You can find more information about type erasure here:
 https://www.bignerdranch.com/blog/breaking-down-type-erasures-in-swift/
 */

private class _AnyFilterBase: AbstractClass, FilterType, CustomStringConvertible {
    
    var attribute: Attribute {
        callMustOverrideError()
    }
    
    var isNegated: Bool {
        get { callMustOverrideError() }
        set { callMustOverrideError() }
    }
    
    var description: String {
        callMustOverrideError()
    }

    func hash(into hasher: inout Hasher) {
        callMustOverrideError()
    }
    
    init() {
        guard type(of: self) != _AnyFilterBase.self else {
            impossibleInitError()
        }
    }
  
    static func == (lhs: _AnyFilterBase, rhs: _AnyFilterBase) -> Bool {
        callMustOverrideError()
    }
    
}

private final class _AnyFilterBox<Concrete: FilterType>: _AnyFilterBase {

    var concrete: Concrete
    
    init(_ concrete: Concrete) {
        self.concrete = concrete
    }
    
    override var attribute: Attribute {
        return concrete.attribute
    }
    
    override var isNegated: Bool {
        get { return concrete.isNegated }
        set { concrete.isNegated = newValue }
    }
    
    override var description: String {
        return concrete.description
    }
      
}

final class AnyFilter: FilterType {
    
    private let box: _AnyFilterBase
    
    init<Concrete: FilterType>(_ concrete: Concrete) {
        box = _AnyFilterBox(concrete)
    }
    
    var attribute: Attribute {
        return box.attribute
    }
  
    var description: String {
      return box.description
    }
    
    var isNegated: Bool {
        get { return box.isNegated }
        set { box.isNegated = newValue }
    }
    
    func extractAsFilter<T: FilterType>() -> T? {
        return (box as? _AnyFilterBox<T>)?.concrete
    }
    
}

extension FilterType {
  
    public mutating func not(value: Bool = true) {
        isNegated = value
    }
  
}
