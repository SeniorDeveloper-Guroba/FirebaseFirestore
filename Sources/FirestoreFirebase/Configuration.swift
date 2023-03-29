//
//  Configuration.swift
//  
//
//  Created by Firestore
//
import Foundation

public struct Configuration {
    
    let advertisingURL: Bool
    let isAdvertising : String
    
    enum CodingKeys: String, CodingKey {
        
        case advertisingURL
        case isAdvertising
    }
}

extension Configuration: Decodable {
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.advertisingURL = try values.decode(Bool.self,   forKey: .advertisingURL)
        self.isAdvertising  = try values.decode(String.self, forKey: .isAdvertising)
    }
}
