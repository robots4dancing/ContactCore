//
//  ViewController.swift
//  ContactCore
//
//  Created by ANI on 1/24/17.
//  Copyright © 2017 Shane Empie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var contactArray = [Contact]()

    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contactArray = appDelegate.fetchAllContacts()
        print("Count \(contactArray.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

