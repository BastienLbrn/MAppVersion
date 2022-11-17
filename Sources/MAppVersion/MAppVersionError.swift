//
//  MAppVersionError.swift
//  
//
//  Created by Bastien Lebrun on 17/11/2022.
//

import Foundation

public enum MAppVersionError: Error {
    case infoDictionaryNotFound
    case versionNotFoundInInfoDictionary
    case versionInvalidInInfoDictionary
    case identifierNotFoundInInfoDictionary
    case lookupURLFailed
    case getStoreVersionCallError
    case getStoreVersionDecodingFailed
    case getStoreVersionResultNotFound
    case getStoreVersionResultInvalid
}
