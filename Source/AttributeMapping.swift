//
//  AttributeMapping.swift
//  AttributeMapping
//
//  Created by Oliver Letterer on 06.08.14.
//  Copyright (c) 2014 Sparrow-Labs. All rights reserved.
//

import Foundation



public class AttributeMapping<T: NSObject> {
    var dictionary = [String: String]()

    init(_ type: T.Type) {}

    func map(string: String, _ block: T -> AnyObject) -> Self {
        let proxy = _SPLAttributeMappingProxy(targetClass: T.self)
        let result = block(unsafeBitCast(proxy, T.self)) as String

        dictionary[string] = result
        return self
    }
}
