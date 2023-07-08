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
    
    public func save<T: RequestData>(requestData: T, completion: @escaping ClosureResult<T.AnyData>) {
		if requestData.documentReference == nil {
			requestData.setDocumentReference()
		}
		
		guard let document = requestData.documentReference else { return }
		
        do {
            try document.setData(from: requestData.data)
            completion(.object(requestData.data))
        } catch let error {
            completion(.error(RequestFirebaseError.invalidSetData))
            print(error.localizedDescription, "error set privacy")
        }
    }
    public init(){}
}
