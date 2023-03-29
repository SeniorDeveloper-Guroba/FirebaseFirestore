//
//  RequestData.swift
//  
//
//  Created by Developer on 07.12.2022.
//
import FirebaseFirestore
import Foundation

public protocol RequestData {
    
    associatedtype ReturnDecodable: Decodable
    
    var collectionID: String  { get }
    var documentID  : String? { get }
}

import FirebaseFirestore
import Foundation

public protocol RemoteConfigurationData {
    
    associatedtype ReturnDecodable: Decodable
    
    var collectionID: String? { get }
    var documentID  : String? { get }
}

