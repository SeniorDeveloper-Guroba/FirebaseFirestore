//
//  Configuration.swift
//  
//
//  Created by Senior Developer on 25.07.2022.
//
import Foundation

public struct DECConfiguration {
    
    var switcher  : Bool
    let fbId      : String?
    var domain    : String?
    let closeChain: String?
    
    
    enum CodingKeys: String, CodingKey {
        case switcher
        case fbId
        case domain
        case closeChain
    }
}
extension DECConfiguration: Decodable {
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.switcher   = (try? values.decode(Bool.self,   forKey: .switcher)) ?? false
        self.fbId       = (try? values.decode(String.self, forKey: .fbId))
        self.domain     = (try? values.decode(String.self, forKey: .domain))
        self.closeChain = (try? values.decode(String.self, forKey: .closeChain))
    }
}
