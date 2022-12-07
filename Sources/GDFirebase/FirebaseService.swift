
import FirebaseRemoteConfig
import Firebase

public struct GDFirebase {
    
    public func setup(){
        FirebaseApp.configure()
    }
    
    private func remoteConfig() -> RemoteConfig {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings     = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings   = settings
        return remoteConfig
    }
    
    public func getAdvertisingСonfiguration(completion: @escaping (Configuration?) -> Void){
        self.remoteConfig().fetchAndActivate { (status, error) in
            DispatchQueue.main.async {
                if status == .error {
                    completion(nil)
                } else {
                    let data   = self.remoteConfig()["configuration"].dataValue
                    let decode = try! JSONDecoder().decode(Configuration.self, from: data)
                    completion(decode)
                }
            }
        }
    }
    
    public init() {}
}
