//
//  TokenGetter.swift
//  Swifty_Companion
//
//  Created by Lehlohonolo MASHIYANE on 2018/10/18.
//  Copyright © 2018 Lehlohonolo MASHIYANE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TokenGetter: NSObject {

    let requestUrl = "https://api.intra.42.fr/v2/users/"
    let UID = "70c0775388c3554b2f5ba4be623155234baee449be63593ac43a49377d80aeda"
    let SecretCode = "88c935aa5a8d46e79dca3a0ef8dba8b5d5bcf68c14d48185ac172e235474ce93"
    let tokenUrl = "https://api.intra.42.fr/oauth/token"
    
    var requestParams = ""
    
    var userName = ""
    
    let Data = userData()
    
    
    //Mark : Get Token for sending request
    func    getToken() {
        let params:[String:String] = ["grant_type" : "client_credentials", "client_id" : UID, "client_secret" : SecretCode]
        Alamofire.request(tokenUrl, method : .post, parameters : params).responseJSON {
            response in
            switch response.result
            {
            case .success :
                let tokenRes : JSON = JSON(response.result.value!)
                
                self.requestParams = self.requestUrl + self.userName
                self.getInfo(token: tokenRes["access_token"].stringValue)
            
            case .failure(let error):
                print(error)
            }
            
            
            }
        }

    //Mark : Get Info about User
    func    getInfo(token : String) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        Alamofire.request(requestParams, headers : headers).responseJSON {
            response in
            switch response.result
            {
            case .success :
                let tokenRes : JSON = JSON(response.result.value!)
                print("Here we go now")
                print(tokenRes.dictionary!)
                self.requestParams = self.requestUrl + self.userName
                self.getInfo(token: tokenRes["access_token"].stringValue)
                self.setParams(tokenRes)
            
            case .failure(let error) :
                print(error)
            }
            
                
            }
        }
    
    func setParams(_ tokenRes: JSON)
    {
        if tokenRes["displayname"] != JSON.null {
            setUserInfo(tokenRes)
        }
        else
        {
            print(Error.self)
        }
    }
    
    func setUserInfo(_ tokenRes : JSON)
    {
        self.Data.nameSurname = tokenRes["displayname"].stringValue
        self.Data.number = tokenRes["phone"].stringValue
        self.Data.points = tokenRes["correction_point"].stringValue
        self.Data.userName = tokenRes["login"].stringValue
        self.Data.email = tokenRes["email"].stringValue
        self.Data.wallet = tokenRes["wallet"].stringValue
        self.Data.place = tokenRes["location"].stringValue
        self.Data.image = tokenRes["image_url"].stringValue
        
        let url = URL(string : Data.image)
        let dataRecieved = NSData(contentsOf: url! as URL)
        //self.Data.showImage = UIImage(data: dataRecieved! as Data)
        
        
        
    }
}
    
    

