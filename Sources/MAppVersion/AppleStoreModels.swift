//
//  AppleStoreModels.swift
//  
//
//  Created by Bastien Lebrun on 17/11/2022.
//

import Foundation

class LookupResult: Decodable {
    var results: [AppInfo]
}

class AppInfo: Decodable {
    var version: String
    var trackViewUrl: String
}

public enum VersionComponent {
    case major
    case minor
    case patch
}
