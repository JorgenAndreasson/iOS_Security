// MARK:- Security test
extension AppDelegate {
    
    /// Test to see if the app has been compromised
    private func testInfoPlist() -> Void {
        if Bundle.main.object(forInfoDictionaryKey: "SignerIdentity") != nil {
           // Answers.logCustomEvent(withName: "Security Breach", customAttributes: ["Status": "Compromised app"])
            fatalError("Compromised app")
        }
    }
    
    /// Test for jailbroken device
    private func testForJailBreak() -> Void {
        if TARGET_IPHONE_SIMULATOR != 1 {
            // Check 1 : existence of files that are common for jailbroken devices
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                || FileManager.default.fileExists(atPath: "/bin/bash")
                || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                || FileManager.default.fileExists(atPath: "/etc/apt")
                || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                || UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!) {
                
              //  Answers.logCustomEvent(withName: "Security Breach", customAttributes: ["Status": "Jailbroken device"])
                fatalError("Jailbroken device")
            }
            // Check 2 : Reading and writing in system directories (sandbox violation)
            let testString = "TestString"
            do {
                try testString.write(toFile: "/private/testString.txt", atomically: true, encoding: String.Encoding.utf8)
              //  Answers.logCustomEvent(withName: "Security Breach", customAttributes: ["Status": "Jailbroken device"])
                fatalError("Jailbroken device")
            } catch {
                return
            }
        }
    }
}
