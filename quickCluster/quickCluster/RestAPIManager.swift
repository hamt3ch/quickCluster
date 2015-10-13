
//
//  RestAPIManager.swift
//  
//
//  Created by DD Admin on 7/19/15.
//
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError) -> Void

class RestAPIManager:NSObject {
      static let sharedInstance = RestAPIManager() //Instantiate Object
  
  let baseURL = "https://api-us.clusterpoint.com/100909/quickCluster.json"
  
  let searchURL = "https://api-us.clusterpoint.com/100909/quickCluster/_search.json"
    
   let insertURL = "https://api-us.clusterpoint.com/100909/quickCluster.json"
  
    
   func pushToServer(onCompletion: (JSON) -> Void){
    makeHTTPRequest(insertURL, onCompletion: {json, err -> Void in
        onCompletion(json)
    })
  }
    
  func getRandomUser(onCompletion: (JSON) -> Void){
    makeHTTPRequest(searchURL, onCompletion: {json, err -> Void in
      onCompletion(json)
    })
  }
  
  func makeHTTPRequest(path: String, onCompletion: ServiceResponse){
    let request = NSMutableURLRequest(URL: NSURL(string: path)!);
    
    let authString: String = "hmiles23@gmail.com:#Swirv22"
    let utf8Str = authString.dataUsingEncoding(NSUTF8StringEncoding)
    
    if let base64Encoded = utf8Str?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    {
      let fullAuth = "Basic " + base64Encoded
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      request.addValue(fullAuth, forHTTPHeaderField: "Authorization")
      request.HTTPMethod = "POST"
        
      let id = ["id":"name"]
        
      let body = [
        "id" : "32424",
//        "id": "78686913",
        "name": "Hugh Miles"
//        "phoneNumber": "9546685225"
      ]
      
      var err: NSError?
      do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(body, options: [])
      } catch var error as NSError {
        err = error
        request.HTTPBody = nil
      }
      
      let session = NSURLSession.sharedSession();
      let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error in
        
        let stuff: NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        let json:JSON = JSON(stuff)
        print(json)
      })
      
      task.resume()
    }
  }
}