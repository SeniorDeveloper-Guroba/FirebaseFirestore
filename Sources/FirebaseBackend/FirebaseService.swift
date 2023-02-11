
import FirebaseRemoteConfig
import Firebase

public class FirebaseService {
    
    public func setup(){
        FirebaseApp.configure()
        remoteConfig()
    }
    
    private func remoteConfig() -> RemoteConfig {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings     = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings   = settings
        return remoteConfig
    }
    
    public init() {}
}
