//
//  ApiHandler.swift
//  TestIOS
//
//  Created by Ibrahim Indosystem on 1/6/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON
import SystemConfiguration

typealias appJSON = [String : AnyObject]
typealias postParam = Parameters


class APIResp: Mappable {
    
    var status : Bool? = false
    var list : JSON? = nil
    
    required init?(map: Map){
        
    }
    
    // Mappable
    func mapping(map: Map) {
        status          <- map["status"]
        list            <- map["list"]
    }
    
}

class APIHandler {

    // reachability checker
    // get iphone reachability status
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    class func getcurrentReachabilityStatus() -> ReachabilityStatus{
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
    
    // cancel all api request
    class func cancelAllRequest(){
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }

    // handle api request with alamofire for json request (swiftyjson)
    class func request( url : String ,requestMethod method : HTTPMethod = .get ,requestParam parameter : Parameters? = nil ,useAuthorizationToken tokenEnabled : Bool = true , checkConnection : Bool = true ,requestEncoding encoding : ParameterEncoding = URLEncoding.default ,requestHeaders headers : [String:String]? = nil, callback : @escaping (APIResp) -> Void){
        
        // if checkConnection Enabled
        if checkConnection {
            if getcurrentReachabilityStatus() == .notReachable {
                print("no internet connection")
                return
            }
        }
        
        LoadingOverlay.shared.showOverlay()
        
        Alamofire.request(url, method: method, parameters: parameter, encoding: encoding, headers: headers).responseObject{ (response : DataResponse<APIResp>) in
            
            LoadingOverlay.shared.hideOverlay()
            
            switch response.result {
            // Automatically validates status code within 200...299 range, and that the Content-Type header of the response matches the Accept header of the request, if one is provided
            case .success(let apiResp):
                
                if apiResp.status == true{
                    callback(apiResp)
                }else{
                    // stop loading
                    LoadingOverlay.shared.hideOverlay()
                    // on login session expired
                    
                    print(apiResp)
                    
                }
                
            case .failure(let error):
                
                LoadingOverlay.shared.hideOverlay()
                print(error.localizedDescription)
                
                let errorJson : JSON = [
                    "status" : false,
                    "list" : ""
                ]
                
                callback(APIResp(JSONString: errorJson.rawString()!)!)
                
            }
            
        }
    }
    
}
