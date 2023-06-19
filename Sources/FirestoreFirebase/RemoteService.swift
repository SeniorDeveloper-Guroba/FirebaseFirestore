//  Configuration.swift
//
//
//  Created by Firestore
//
import FirebaseRemoteConfig
import Firebase

public class RemoteService {
    
    private let configurationID = "configuration"
    
    private func remoteConfig() -> RemoteConfig {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings     = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings   = settings
        return remoteConfig
    }
    
    public func getConfiguration<T: RequestData>(requestData: T, completion: @escaping ClosureResult<T.AnyData>) {
        self.remoteConfig().fetchAndActivate { (status, error) in
            DispatchQueue.main.async { [self] in
                if status == .error {
                    completion(.error(nil))
                } else {
                    let data = self.remoteConfig()[configurationID].dataValue
                    do {
                        let object = try JSONDecoder().decode(T.AnyData.self, from: data)
                        completion(.object(object))
                    } catch {
                        completion(.error(nil))
                    }
                }
            }
        }
    }
    
    public func getBoolValue(key: String, completion: @escaping Closure<Bool>) {
        self.remoteConfig().fetchAndActivate { (status, error) in
            let boolValue = self.remoteConfig()[key].boolValue
            completion(boolValue)
        }
    }
    
    public func getStringValue(key: String, completion: @escaping Closure<String>) {
        self.remoteConfig().fetchAndActivate { (status, error) in
            if let stringValue = self.remoteConfig()[key].stringValue {
                completion(stringValue)
            }
        }
    }
    
    public init() {}
}
