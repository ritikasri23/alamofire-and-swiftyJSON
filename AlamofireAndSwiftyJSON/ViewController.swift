//
//  ViewController.swift
//  AlamofireAndSwiftyJSON
//
//  Created by Ritika Srivastava on 28/01/18.
//  Copyright © 2018 Ritika Srivastava. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
 //Array of dictionary
 var arrRes = [[String:AnyObject]]()
    
    @IBOutlet weak var tableViewJSON: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeRequest()
        
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jsonCell")!
            var dict = arrRes[indexPath.row]
            cell.textLabel?.text = dict["source"]?["name"] as? String
            cell.detailTextLabel?.text = dict["title"] as? String
            return cell
        }
    
    func makeRequest(){
        
        //Make a request with Alamofire
        
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=c694e9ad21c744f08cc48c8f06300a57").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                //Deal data with SwiftyJson :)
                let swiftyJsonVar = JSON(responseData.result.value!)
                //Print to see the value of response
                print(swiftyJsonVar)
                if let resData = swiftyJsonVar["articles"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tableViewJSON.reloadData()
                }
            }
        }
        
    }
        
}




