//
//  CheckVersion.swift
//  FreewillSphere
//
//  Created by Pitchaorn on 22/10/2561 BE.
//  Copyright © 2561 Freewill Solutions. All rights reserved.
//

import Foundation

class CheckVersion:NSObject{
    enum VersionError: Error {
        case invalidResponse, invalidBundleInfo
    }
    
    lazy var defaultSession: URLSession = {
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
        return session
    }()
    
    func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                throw VersionError.invalidBundleInfo
        }
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw VersionError.invalidResponse }
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
                    throw VersionError.invalidResponse
                }
                 var newVersionExists = false
                if currentVersion.compare(version, options: .numeric) == .orderedAscending{
                     newVersionExists = true
                }
                completion(newVersionExists, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }
    
}

extension CheckVersion: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
}
