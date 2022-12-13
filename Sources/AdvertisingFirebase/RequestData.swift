//
//  RequestData.swift
//  GDFirebase
//
//  Created by Senior Developer on 07.12.2022.
//
import FirebaseFirestore
import Foundation

public protocol RequestDataAdvertising {
    
    associatedtype ReturnDecodable: Decodable
    
    var collectionID: String { get }
    var documentID  : String { get }
}
