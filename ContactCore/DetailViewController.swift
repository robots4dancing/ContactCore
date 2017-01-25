//
//  DetailViewController.swift
//  ContactCore
//
//  Created by ANI on 1/24/17.
//  Copyright © 2017 Shane Empie. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet var saveButton            :UIBarButtonItem!
    @IBOutlet var firstNameTextField    :UITextField!
    @IBOutlet var lastNameTextField     :UITextField!
    @IBOutlet var phoneTextField        :UITextField!
    
    var currentContact                  :Contact?
    var managedContext                  :NSManagedObjectContext!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - Core Methods
    
    func display(contact: Contact) {
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        phoneTextField.text = contact.phoneNumber
    }
    
    func setConactValues(contact: Contact) {
        contact.firstName = firstNameTextField.text
        contact.lastName = lastNameTextField.text
        contact.phoneNumber = phoneTextField.text
        if let _ = currentContact {
            contact.dateUpdated = NSDate()
        } else {
            contact.dateEntered = NSDate()
        }
    }
    
    func createContact() {
        let newContact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: managedContext) as! Contact
        setConactValues(contact: newContact)
        appDelegate.saveContext()
    }
    
    func editContact(contact: Contact) {
        setConactValues(contact: contact)
        appDelegate.saveContext()
    }
    
    //MARK: - Interactivity Methods
    
    @IBAction func savedPressed(button: UIBarButtonItem) {
        if let contact = currentContact {
            editContact(contact: contact)
        } else {
            createContact()
        }
        self.navigationController!.popViewController(animated: true)
    }
    
    //MARK: - Life Cycle Methods
    

    override func viewDidLoad() {
        super.viewDidLoad()
        managedContext = appDelegate.persistentContainer.viewContext
        if let contact = currentContact {
            display(contact: contact)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


