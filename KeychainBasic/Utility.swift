//
//  Utility.swift
//  KeychainBasic
//
//  Created by Lyubomir Yordanov on 11/16/22.
//

import Foundation

enum KeychainError: Error {
    
    case duplicate
    case unknownError(status: OSStatus)
}

func save(credentials: Credentials) throws {
    
    var attributes = [String: Any]()
    attributes[kSecClass as String] = kSecClassGenericPassword
    attributes[kSecAttrService as String] = "credentials"
    attributes[kSecAttrAccount as String] = credentials.username
    attributes[kSecAttrGeneric as String] = credentials.password.data(using: String.Encoding.utf8)
    
    let status = SecItemAdd(attributes as CFDictionary, nil)
    
    guard status != errSecDuplicateItem else {
        
        print("duplicateeeeee")
        throw KeychainError.duplicate
    }
    
    guard status == errSecSuccess else {
        
        throw KeychainError.unknownError(status: status)
    }
}

func get() -> (String, String)? {
    
    var query = [String: Any]()
    query[kSecClass as String] = kSecClassGenericPassword
    query[kSecAttrService as String] = "credentials"
    query[kSecMatchLimit as String] = kSecMatchLimitOne
    query[kSecReturnAttributes as String] = kCFBooleanTrue
    
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    
    guard
        status == errSecSuccess,
        let item = result as? NSDictionary,
        let data = item[kSecAttrGeneric as String] as? Data,
        let username = item[kSecAttrAccount as String] as? String,
        let password = String(data: data, encoding: .utf8) else {
        
        return nil
    }
    
    return (username, password)
}

func getAll() -> [(String, String)] {
    
    var query = [String: Any]()
    query[kSecClass as String] = kSecClassGenericPassword
    query[kSecAttrService as String] = "credentials"
    query[kSecMatchLimit as String] = kSecMatchLimitAll
    query[kSecReturnAttributes as String] = kCFBooleanTrue
    
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    
    if status == errSecSuccess,
       let items = result as? [[String: Any]] {
        
        var result = [(username: String, password: String)]()
        
        for item in items {
            if
            let data = item[kSecAttrGeneric as String] as? Data,
            let username = item[kSecAttrAccount as String] as? String,
            let password = String(data: data, encoding: .utf8) {
                result.append((username: username, password: password))
            }
        }
        
        return result
    }
        
    return []
}

func remove(username: String) throws {
    
    var query = [String: Any]()
    query[kSecClass as String] = kSecClassGenericPassword
    query[kSecAttrService as String] = "credentials"
    query[kSecAttrAccount as String] = username
    
    let status = SecItemDelete(query as CFDictionary)
    
    guard status == errSecSuccess else {
        
        throw KeychainError.unknownError(status: status)
    }
}
