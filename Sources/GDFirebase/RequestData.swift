//
//  RequestData.swift
//  GDFirebase
//
//  Created by Senior Developer on 07.12.2022.
//
import FirebaseFirestore
import Foundation

public protocol RequestData {
    
    associatedtype ReturnDecodable: Decodable
    
    var collection: CollectionReference? { get }
    var document  : DocumentReference?   { get }
    var documentID: String?              { get }
}

import FirebaseFirestore
import Foundation

public protocol RemoteConfigurationData {
    
    associatedtype ReturnDecodable: Decodable
    
    var collection: CollectionReference? { get }
    var document  : DocumentReference?   { get }
    var documentID: String?              { get }
}

