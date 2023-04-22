//
//  TypeNames.swift
//  
//
//  Created by Developer on 06.12.2022.
//
import FirebaseFirestore
import Foundation

//MARK: - CLOUSURES
public typealias Closure<T>       = ((T) -> Void)
public typealias ClosureEmpty     = (() -> Void)
public typealias ClosureTwo<T, G> = ((T, G) -> Void)
public typealias ClosureAny       = ((Any?) -> Void)

public typealias ClosureResult<T: Decodable> = ((FirebaseResult<T>) -> Void)

public enum FirebaseResult<T: Decodable> {
    
    case object(T?)
    case error(Error?)
}
