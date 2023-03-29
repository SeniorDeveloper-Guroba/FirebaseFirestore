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
    
    public func getConfiguration<T: RequestData>(requestData: T, completion: @escaping ClosureResult<T.ReturnDecodable>) {
        self.remoteConfig().fetchAndActivate { (status, error) in
            DispatchQueue.main.async { [self] in
                if status == .error {
                    completion(.error(nil))
                } else {
                    let data = self.remoteConfig()[configurationID].dataValue
                    do {
                        let object = try JSONDecoder().decode(T.ReturnDecodable.self, from: data)
                        completion(.object(object))
                    } catch {
                        completion(.error(nil))
                    }
                }
            }
        }
    }
    
    public init() {}
}
