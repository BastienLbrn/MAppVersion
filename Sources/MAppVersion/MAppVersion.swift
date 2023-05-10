//
//  MAppVersion.swift
//
//
//  Created by Bastien Lebrun on 17/11/2022.
//

import UIKit

public struct MAppVersion {
    
    public static var current = MAppVersion()
    
    private init() {}
    
    private static let bundleShortVersionKey = "CFBundleShortVersionString"
    private static let bundleIdentifier = "CFBundleIdentifier"
    private static let lookupPath = "http://itunes.apple.com/lookup?bundleId="
    
    public var appStoreLink: String?
    public var currentVersion: MAppVersionValue?
    public var appStoreVersion: MAppVersionValue?
    
    public static func needUpdate(notify: VersionComponent? = nil, force: VersionComponent? = nil) async -> (willNotify: Bool, willForce: Bool) {
        
        guard let storeVersion = try? await getStoreVersion().get(),
              let appVersion = try? getCurrentVersion().get()
        else { return (false, false) }
        
        guard storeVersion != appVersion else { return (false, false) }
        
        switch force {
        case .none: break
        case .some(.major):
            let needUpdate = storeVersion.major > appVersion.major
            if needUpdate {
                return (true, true)
            }
        case .some(.minor):
            let needUpdate = storeVersion.minor > appVersion.minor
            if needUpdate {
                return (true, true)
            }
        case .some(.patch):
            let needUpdate = storeVersion.patch > appVersion.patch
            if needUpdate {
                return (true, true)
            }
        }
        
        switch notify {
        case .none: break
        case .some(.major):
            let needUpdate = storeVersion.major > appVersion.major
            if needUpdate {
                return (true, false)
            }
        case .some(.minor):
            let needUpdate = storeVersion.minor > appVersion.minor
            if needUpdate {
                return (true, false)
            }
        case .some(.patch):
            let needUpdate = storeVersion.patch > appVersion.patch
            if needUpdate {
                return (true, false)
            }
        }
        
        return (false, false)
    }
    
    public static func getCurrentVersion() -> Result<MAppVersionValue, MAppVersionError> {
        guard let info = Bundle.main.infoDictionary else {
            return .failure(.infoDictionaryNotFound)
        }
        guard let currentVersionBundle = info[bundleShortVersionKey] as? String else {
            return .failure(.versionNotFoundInInfoDictionary)
        }
        guard let currentVersion = MAppVersionValue(from: currentVersionBundle) else {
            return .failure(.versionInvalidInInfoDictionary)
        }
        current.currentVersion = currentVersion
        return .success(currentVersion)
    }
    
    public static func getStoreVersion() async -> Result<MAppVersionValue, MAppVersionError> {
        guard let info = Bundle.main.infoDictionary else {
            return .failure(.infoDictionaryNotFound)
        }
        guard let identifier = info[bundleIdentifier] as? String else {
            return .failure(.identifierNotFoundInInfoDictionary)
        }
        guard let lookupURL = URL(string: lookupPath + identifier) else {
            return .failure(.lookupURLFailed)
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: lookupURL) else {
            return .failure(.getStoreVersionCallError)
        }
        
        guard let result = try? JSONDecoder().decode(LookupResult.self, from: data) else {
            return .failure(.getStoreVersionDecodingFailed)
        }
        
        guard let result = result.results.first else {
            return .failure(.getStoreVersionResultNotFound)
        }
        
        current.appStoreLink = result.trackViewUrl
        
        guard let storeVersion = MAppVersionValue(from: result.version) else {
            return .failure(.getStoreVersionResultInvalid)
        }
        
        current.appStoreVersion = storeVersion
        
        return .success(storeVersion)
    }
}
