//
//  AddToDoController.swift
//  to_do_app
//
//  Created by as-131866 on 12.01.16.
//  Copyright (c) 2016 as-131866. All rights reserved.
//

import UIKit
import CoreData

class AddToDoController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var toDoOutlet: UITextField!
    @IBOutlet weak var beschreibungOutlet: UITextField!
    @IBOutlet weak var datumOutlet: UITextField!
    
    var toDoTextField="";
    var beschreibungTextField="";
    var datumTextField=String.init();
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    @IBAction func clickedSaveButton(sender: UIButton) {
       
        if toDoTextField == "" {
        
        
        
        
        } else {
            //Zugriff auf Core Data
            let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            //ManagedObjectContext verwaltet sämtliche Datenobjekte
            let context: NSManagedObjectContext = appDel.managedObjectContext!
            
            //Ein neues ToDo anlegen für die Entity "toDo" in CoreData
            let newToDo = NSEntityDescription.insertNewObjectForEntityForName("toDo", inManagedObjectContext: context)
            newToDo.setValue(toDoTextField, forKey: "toDoName")
            newToDo.setValue(beschreibungTextField, forKey: "toDoDescription")
            newToDo.setValue(datumTextField, forKey: "toDoDate")
            
            //das toDo der Entity hinzufügen
            context.save()
            
            // Nach Klicken des Save Buttons wird ein Segue ausgeführt zurück zur TableView.
            // Manueller Segue.
            performSegueWithIdentifier("SaveButton", sender: self)
            
            
        
        
        
        
        
        
        }
        
        
        
        
        
    }
    
    
    // Implementierte Funktion von UITextFieldDelegate.
    // Reagiert auf gedrückten Return-Button innerhalb der beiden Textfelder.
    // Wichtig: Outlets müssen vorher beim ViewController als OutletDelegate registriert werden!
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case toDoOutlet:
            toDoTextField = toDoOutlet.text!
            beschreibungOutlet.becomeFirstResponder()
        case beschreibungOutlet:
            beschreibungTextField = beschreibungOutlet.text!
            datumOutlet.becomeFirstResponder()
        case datumOutlet:
            datumTextField = datumOutlet.text!
            datumOutlet.resignFirstResponder()
        default:
            print("Wrong case in func textFieldShouldReturn AddToDoViewController.")
        }
        
        return true
    }
    
    // Funktion handelt die Datenübertragung via Segue.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "savedToDoSegue" {
            let destinationController = segue.destinationViewController as! ViewController
            destinationController.toDoName = toDoTextField
            destinationController.toDoDescription = beschreibungTextField
            destinationController.toDoEstimatedTime = datumTextField
        } else if segue.identifier == "SaveButton" {
            print("Segue.identifier: \(segue.identifier).")
        }
    }
    
    
    
}
