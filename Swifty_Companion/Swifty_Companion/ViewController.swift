//
//  ViewController.swift
//  Swifty_Companion
//
//  Created by Lehlohonolo MASHIYANE on 2018/10/18.
//  Copyright © 2018 Lehlohonolo MASHIYANE. All rights reserved.
//

import UIKit
import  Alamofire

class ViewController: UIViewController {

    var tokeniser = TokenGetter()
    
    @IBAction func searcher(_ sender: Any) {
        tokeniser.userName = textField.text!
        print(tokeniser.userName)
        tokeniser.getToken()
        
    }
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //tokeniser.userName = textField.text!
        //tokeniser.tokenGetter()
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueIdentifier"
        {
            print("Clicked Segue")
        }
    }
}

