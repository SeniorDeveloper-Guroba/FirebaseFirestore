//
//  FirestoreConfiguration.swift
//  
//
//  Created by Senior Developer on 06.12.2022.
//
import FirebaseFirestoreSwift
import FirebaseFirestore
import Foundation

public class FirestoreService {
    
    private let reference = Firestore.firestore()
    
    public func get<T: RequestData>(requestData: T, completion: @escaping ClosureResult<T.ReturnDecodable>) {
        
        let document = reference.collection(requestData.collectionID).document(requestData.documentID)
        
        document.addSnapshotListener { (document, error) in
            
            if let error = error {
                completion(.error(error))
                return
            }
            
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
