//  Configuration.swift
//
//
//  Created by Firestore
//
import FirebaseFirestoreSwift
import FirebaseFirestore
import Foundation

public class FirestoreService {
    
    private let getFirestoreService = GetFirestoreService()
    private let saveFirestoreService = SaveFirestoreService()
    private let getListenerFirestoreService = GetListenerFirestoreService()
    
    public func getSnapshotListener<T: RequestData>(requestData: T, completion: @escaping ClosureResult<[T.AnyData]>) {
		let documentReference = requestData.documentReference
        switch documentReference == nil {
            case true:
                getListenerFirestoreService.getSnapshotListenerForCollection(
                    requestData: requestData,
                    completion: completion
                )
            case false:
                getListenerFirestoreService.getSnapshotListenerForDocument(
                    requestData: requestData,
                    completion: completion
                )
        }
    }
    
    public func get<T: RequestData>(requestData: T, completion: @escaping ClosureResult<[T.AnyData]>) {
        let documentReference = requestData.documentReference
        switch documentReference == nil {
            case true:
                getFirestoreService.getForCollection(
                    requestData: requestData,
                    completion: completion
                )
            case false:
                getFirestoreService.getForDocument(
                    requestData: requestData,
                    completion: completion
                )
        }
    }
    
    public func save<T: RequestData>(requestData: T, completion: @escaping ClosureResult<T.AnyData>) {
        saveFirestoreService.save(
            requestData: requestData,
            completion: completion
        )
    }
    public init() {}
}
