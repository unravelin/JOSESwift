//
//  JWKSet.swift
//  JOSESwift
//
//  Created by Daniel Egger on 15.02.18.
//
//  ---------------------------------------------------------------------------
//  Copyright 2019 Airside Mobile Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  ---------------------------------------------------------------------------
//

import Foundation

/// A JWK set is a structure that represents a set of JWKs.
struct JWKSet {

    /// The `keys` member is an array of JWKs.
    let keys: [JWK]

    /// Initializes a `JWKSet` containing the given keys.
    ///
    /// - Parameter keys: The keys that the JWK set should contain.
    init(keys: [JWK]) {
        self.keys = keys
    }

    /// Initializes a `JWKSet` from given JSON data.
    ///
    /// - Parameter data: The data containing the JWK set.
    /// - Throws: A `DecodingError` with relevant information.
    init(data: Data) throws {
        self = try JSONDecoder().decode(JWKSet.self, from: data)
    }

    /// Computes the JSON representation of the `JWKSet`.
    ///
    /// - Returns: The JSON representation of the JWK set as `String` or
    ///            `nil` if the encoding failed.
    func jsonString() -> String? {
        guard let json = try? JSONEncoder().encode(self) else {
            return nil
        }

        return String(data: json, encoding: .utf8)
    }

    /// Computes the JSON representation of the `JWKSet`.
    ///
    /// - Returns: The JSON representation of the JWK set as `Data` or
    ///            `nil` if the encoding failed.
    func jsonData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

extension JWKSet: Collection {
    typealias ArrayType = [JWK]

    typealias Element = ArrayType.Element
    typealias Index = ArrayType.Index
    typealias Iterator = ArrayType.Iterator

    var startIndex: Index {
        return self.keys.startIndex
    }

    var endIndex: Index {
        return self.keys.endIndex
    }

    public subscript(index: Index) -> Element {
        return keys[index]
    }

    func index(after index: Index) -> Index {
        return self.keys.index(after: index)
    }

    func makeIterator() -> IndexingIterator<ArrayType> {
        return self.keys.makeIterator()
    }
}

extension JWKSet: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = Element

    init(arrayLiteral elements: ArrayLiteralElement...) {
        var keys: [Element] = []
        for element in elements {
            keys.append(element)
        }

        self.init(keys: keys)
    }
}
