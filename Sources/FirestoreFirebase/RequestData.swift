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
    associatedtype SaveEncodable: Encodable
    
    var collectionID: String   { get }
    var documentID  : String?  { get }
    var data        : SaveEncodable? { get set }
}
public protocol RemoteConfigurationData {
    
    associatedtype ReturnDecodable: Decodable
    
    var collectionID: String? { get }
    var documentID  : String? { get }
}

public enum RequestFirebaseError: LocalizedError {
    case invalidGetDocument
    case invalidGetCollection
    case invalidInternet
    case invalidSetData
}
