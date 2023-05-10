//
//  RequestData.swift
//  
//
//  Created by Developer on 07.12.2022.
//
import FirebaseFirestore
import Foundation

public protocol RequestData {
    
    associatedtype AnyData: Codable
    
    var collectionID: String   { get }
    var documentID  : String?  { get }
    var data        : AnyData? { get set }
}
public protocol RemoteConfigurationData {
    
    associatedtype AnyData: Codable
    
    var collectionID: String? { get }
    var documentID  : String? { get }
}

public enum RequestFirebaseError: LocalizedError {
    case invalidGetDocument
    case invalidGetCollection
    case invalidInternet
    case invalidSetData
}
