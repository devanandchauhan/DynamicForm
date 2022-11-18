//
//  Bundle+.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import Foundation

extension Bundle {
    
    /// Responsible for converting DTO
    ///
    /// - Parameter type: Type
    /// - Parameter file: String
    /// - Parameter decoder: JSONDecoder
    func decode<T: Decodable>(_ type: T.Type, from file: String, decoder: JSONDecoder = JSONDecoder()) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error)")
        }
    }
}
