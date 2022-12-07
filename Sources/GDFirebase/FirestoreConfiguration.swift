//
//  FirestoreConfiguration.swift
//  
//
//  Created by Senior Developer on 06.12.2022.
//
import FirebaseFirestoreSwift
import Foundation

public struct FirestoreConfiguration {
    
    public func getDocument<T: RequestData>(requestData: T, completion: @escaping ClosureResult<T.ReturnDecodable>) {
        
        requestData.document?.addSnapshotListener { (document, error) in
            
            if let document = document, document.exists {
                do {
                    let object = try document.data(as: T.ReturnDecodable.self)
                    completion(.object(object))
                } catch let error {
                    completion(.error(error))
                }
            }
        }
    }
    
    public func getCollection<T: RequestData>(requestData: T, completion: @escaping ClosureResult<T.ReturnDecodable>) {
        
        guard let documentID = requestData.documentID else { return }
        
        requestData.collection?.document(documentID).addSnapshotListener {(document, error) in
        
            if let document = document, document.exists {
                do {
                    let object = try document.data(as: T.ReturnDecodable.self)
                    completion(.object(object))
                } catch let error {
                    completion(.error(error))
                }
            }
        }
    }
    
    public init() {}
}
