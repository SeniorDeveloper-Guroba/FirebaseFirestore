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
		
		guard let documentReference = requestData.documentReference else { return }
        
		documentReference.getDocument { document, error in
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
       
		guard let collectionReference = requestData.collectionReference else { return }
        
		collectionReference.getDocuments { querySnapshot, error in
            
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
    
    public func getForDocument<T: RequestData>(requestData: T) async throws -> [T.AnyData]? {
		
		guard let documentReference = requestData.documentReference else { return nil }
        
        do {
            let object = try await documentReference.getDocument(as: T.AnyData.self)
            return [object]
        } catch let error {
            throw error
        }
    }
    
    public func getForCollection<T: RequestData>(requestData: T) async throws -> [T.AnyData]?  {

		guard let collectionReference = requestData.collectionReference else { return nil }
        
        do {
            let objects = try await collectionReference.getDocuments().documents.compactMap({ document in
                try? document.data(as: T.AnyData.self)
            })
            return objects
            
        } catch let error {
            throw error
        }
    }
    
    public init(){}
}
