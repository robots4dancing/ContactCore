//
//  ViewController.swift
//  ContactCore
//
//  Created by ANI on 1/24/17.
//  Copyright © 2017 Shane Empie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var contactArray = [Contact]()
    
    @IBOutlet var contactTableView  : UITableView!
    
    //MARK: - Interavtivity Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueListToEdit" {
            let indexPath = contactTableView.indexPathForSelectedRow!
            let currentContact = contactArray[indexPath.row]
            let destVC = segue.destination as! DetailViewController
            destVC.currentContact = currentContact
            contactTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentContact = contactArray[indexPath.row]
        cell.textLabel!.text = currentContact.lastName! + ", " + currentContact.firstName!
        cell.detailTextLabel!.text = currentContact.phoneNumber
        return cell
    }

    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contactArray = appDelegate.fetchAllContacts()
        print("Count \(contactArray.count)")
        contactTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

