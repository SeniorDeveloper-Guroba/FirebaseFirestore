//
//  FirestoreService.swift
//  
//
//  Created by Developer on 06.12.2022.
//
import FirebaseFirestoreSwift
import FirebaseFirestore
import Foundation

public class FirestoreService {
    
    private let getFirestoreService = GetFirestoreService()
    private let getListenerFirestoreService = GetListenerFirestoreService()
    
    public func getSnapshotListener<T: RequestData>(requestData: T, completion: @escaping ClosureResult<[T.ReturnDecodable]>) {
        let documentID = requestData.documentID ?? ""
        switch documentID.isEmpty {
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
    
    public func get<T: RequestData>(requestData: T, completion: @escaping ClosureResult<[T.ReturnDecodable]>) {
        let documentID = requestData.documentID ?? ""
        switch documentID.isEmpty {
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
    public init() {}
}
