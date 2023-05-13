//  Configuration.swift
//
//
//  Created by Firestore
//
import FirebaseFirestore
import Foundation

public struct GetFirestoreService {
    
    private let reference = Firestore.firestore()
    
    public func getForDocument<T: RequestData>(requestData: T, completion: @escaping ClosureResult<[T.AnyData]>) {
        let documentID = requestData.documentID ?? ""
        let document = reference
            .collection(requestData.collectionID)
            .document(documentID)
        
        document.getDocument { document, error in
            if let error = error {
                completion(.error(error))
                return
            }
            
            if let document = document, document.exists {
                do {
                    let object = try document.data(as: T.AnyData.self)
                    completion(.object([object]))
                } catch let error {
                    completion(.error(error))
                }
            } else {
                completion(.error(nil))
            }
        }
    }
    
    public func getForCollection<T: RequestData>(requestData: T, completion: @escaping ClosureResult<[T.AnyData]>) {
        
        let collection = reference.collection(requestData.collectionID)
        
        collection.getDocuments { querySnapshot, error in
            
            if let error = error {
                completion(.error(error))
                return
            }
            
            let objects = querySnapshot?.documents.compactMap({ document in
                do {
                    let object = try? document.data(as: T.AnyData.self)
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
    
    // Acync await
    
    public func getForDocument<T: RequestData>(requestData: T) async throws -> [T.AnyData] {
        let documentID = requestData.documentID ?? ""
        let document = reference
            .collection(requestData.collectionID)
            .document(documentID)
        
        do {
            let object = try await document.getDocument(as: T.AnyData.self)
            return [object]
        } catch let error {
            throw error
        }
    }
    
    public func getForCollection<T: RequestData>(requestData: T) async throws -> [T.AnyData]  {
        
        let collection = reference.collection(requestData.collectionID)
        
        do {
            let objects = try await collection.getDocuments().documents.compactMap({ document in
                try? document.data(as: T.AnyData.self)
            })
            return objects
            
        } catch let error {
            throw error
        }
    }
    
    public init(){}
}
