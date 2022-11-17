//
//  MAppVersionValue.swift
//  
//
//  Created by Bastien Lebrun on 17/11/2022.
//

import Foundation

public struct MAppVersionValue {
    var major: Int
    var minor: Int
    var patch: Int
    
    init?(from string: String) {
        var versions = string.split(separator: ".").compactMap { Int($0) }
        // Ensure we have at least 2 versions
        guard versions.count >= 2 else { return nil }
        self.major = versions.removeFirst()
        self.minor = versions.removeFirst()
        // Ensure we have the patch version in the input string otherwise fill it with 0
        guard versions.count > 0 else { self.patch = 0; return }
        self.patch = versions.removeFirst()
    }
    
    init(major: Int = 0, minor: Int = 0, patch: Int = 0) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
}

extension MAppVersionValue: Equatable, Comparable {
    
    public static func < (lhs: MAppVersionValue, rhs: MAppVersionValue) -> Bool {
        guard lhs.major == rhs.major else { return lhs.major < rhs.major }
        guard lhs.minor == rhs.minor else { return lhs.minor < rhs.minor }
        return lhs.patch < rhs.patch
    }
    
}
