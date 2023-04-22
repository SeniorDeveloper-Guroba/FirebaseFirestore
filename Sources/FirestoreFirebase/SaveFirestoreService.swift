//
//  SaveFirestoreService.swift
//  
//
//
import FirebaseFirestore
import Foundation
import FirebaseCore

public struct SaveFirestoreService {
    
    private let reference = Firestore.firestore()
    
    public func save<T: RequestData>(requestData: T, completion: @escaping ClosureResult<[T.ReturnDecodable]>) {
        let documentID = requestData.documentID ?? ""
        let document = reference
            .collection(requestData.collectionID)
            .document(documentID)
        do {
            try document.setData(from: requestData.data)
            let returnData = (requestData.data == nil) ? [] : [requestData.data!]
//            completion(.object(returnData))
        } catch let error {
            completion(.error(RequestFirebaseError.invalidSetData))
            print(error.localizedDescription, "error set privacy")
        }
    }
    public init(){}
}
