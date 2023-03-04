//
//  GetListenerFirestoreService.swift
//  
//
//  Created by Developer on 12.02.2023.
//
import FirebaseFirestore
import Foundation

struct GetListenerFirestoreService {
    
    private let reference = Firestore.firestore()
    
    public func getSnapshotListenerForDocument<T: RequestData>(requestData: T, completion: @escaping ClosureResult<[T.ReturnDecodable]>) {
        let documentID = requestData.documentID ?? ""
        let document = reference
            .collection(requestData.collectionID)
            .document(documentID)
        
        document.addSnapshotListener { (document, error) in
            if let error = error {
                completion(.error(error))
                return
            }
            
            if let document = document, document.exists {
                do {
                    let object = try document.data(as: T.ReturnDecodable.self)
                    completion(.object([object]))
                } catch let error {
                    completion(.error(error))
                }
            }
        }
    }
    
    public func getSnapshotListenerForCollection<T: RequestData>(requestData: T, completion: @escaping ClosureResult<[T.ReturnDecodable]>) {
        
        let collection = reference.collection(requestData.collectionID)
        
        collection.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                completion(.error(error))
                return
            }
            
            let objects = querySnapshot?.documents.compactMap({ document in
                do {
                    let object = try? document.data(as: T.ReturnDecodable.self)
                    return object
                }
            })
            guard let objects = objects, !objects.isEmpty else {
                completion(.error(error))
                return
            }
            completion(.object(objects))
        }
    }
    
    public init(){}
}
