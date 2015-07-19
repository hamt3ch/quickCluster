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
      
      let body = [
        "query": "*"
//        "id": "asdffffff",
//        "name": "bob",
//        "phoneNumber": "123456789"
      ]
      
      var err: NSError?
      request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body, options: nil, error: &err)
      
      let session = NSURLSession.sharedSession();
      let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error in
        
        let stuff: NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        let json:JSON = JSON(stuff)
        println(json)
      })
      
      task.resume()
    }
    
    
    
  }
}