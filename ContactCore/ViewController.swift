//
//  ViewController.swift
//  ContactCore
//
//  Created by ANI on 1/24/17.
//  Copyright © 2017 Shane Empie. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var contactArray = [Contact]()
    
    var managedContext                  :NSManagedObjectContext!
    
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contactToDelete = contactArray[indexPath.row]
            managedContext.delete(contactToDelete)
            appDelegate.saveContext()
            contactArray = appDelegate.fetchAllContacts()
            contactTableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.isEditing = false
        }
    }

    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        managedContext = appDelegate.persistentContainer.viewContext
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

