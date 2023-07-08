//
//  RequestData.swift
//  
//
//  Created by Developer on 07.12.2022.
//
import FirebaseFirestore
import Foundation

public protocol RequestData: AnyObject {
    
    associatedtype AnyData: Codable
    
	var collectionReference: CollectionReference? { get set }
	var documentReference  : DocumentReference?   { get set }
    var collectionID       : String?  { get }
    var documentID         : String?  { get }
    var data               : AnyData? { get set }
}

public extension RequestData {
	
	func setDocumentReference(){
		let reference = Firestore.firestore()
		if let collectionID = collectionID, let documentID = documentID {
			self.documentReference = reference
				.collection(collectionID)
				.document(documentID)
		}
	}
	
	func setCollectionReference(){
		let reference = Firestore.firestore()
		if let collectionID = collectionID {
			self.collectionReference = reference
				.collection(collectionID)
		}
	}
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
