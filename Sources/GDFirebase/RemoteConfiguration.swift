//
//  RemoteConfiguration.swift
//  
//
//  Created by Senior Developer on 06.12.2022.
//
import FirebaseRemoteConfig
import Firebase

public struct RemoteConfiguration {
    
    private let configurationID = "configuration"
    
    private func remoteConfig() -> RemoteConfig {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings     = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings   = settings
        return remoteConfig
    }
    
    public func getConfiguration<T: RemoteConfigurationData>(requestData: T, completion: @escaping ClosureResult<T.ReturnDecodable>) {
        self.remoteConfig().fetchAndActivate { (status, error) in
            DispatchQueue.main.async {
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
