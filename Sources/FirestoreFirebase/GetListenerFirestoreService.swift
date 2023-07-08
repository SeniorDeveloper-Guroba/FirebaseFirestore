//  Configuration.swift
//
//
//  Created by Firestore
//
import FirebaseFirestore
import Foundation

struct GetListenerFirestoreService {
    
	
    public func getSnapshotListenerForDocument<T: RequestData>(requestData: T, completion: @escaping ClosureResult<[T.AnyData]>) {
       
		let documentReference = requestData.documentReference
		
		documentReference?.addSnapshotListener { (document, error) in
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
            }
        }
    }
    
    public func getSnapshotListenerForCollection<T: RequestData>(requestData: T, completion: @escaping ClosureResult<[T.AnyData]>) {
        
		let collectionReference = requestData.collectionReference
        
		collectionReference?.addSnapshotListener { querySnapshot, error in
            
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
    
    public init(){}
}
