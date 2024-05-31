//
//  MockReader.swift
//  MockKit
//
//  Created by Dursun YILDIZ on 29.05.2024.
//

import Foundation
public enum MockReader {
    public static func loadArray<T: Codable>(name: String) -> [T] {
        if let path = Bundle.module.url(forResource: name, withExtension: "json"){
            do {
                let data = try Data(contentsOf: path)

                let result = try JSONDecoder().decode([T].self, from: data)

                return result
            } catch {
                return []
            }
        }

        return []
    }

    public static func loadObject<T: Codable>(name: String) -> T? {
        if let path = Bundle.module.url(forResource: name, withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)

                let result = try JSONDecoder().decode(T.self, from: data)

                return result
            } catch {
                return nil
            }
        }

        return nil
    }
}
