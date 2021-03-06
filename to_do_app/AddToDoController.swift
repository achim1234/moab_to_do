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
    
    var toDoName = ""
    var beschreibungName = ""
    var datumName = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    @IBAction func clickedSaveButton(sender: UIButton) {
       
        if toDoOutlet.text == "" {
            print("kein to do eingetragen")
            let alertController = UIAlertController(title: "ERROR", message: "Titel fehlt!", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        
        
        }
        else {
            
            var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var context:NSManagedObjectContext! = appDel.managedObjectContext
            
            
            var todo_item = NSEntityDescription.insertNewObjectForEntityForName("ToDos", inManagedObjectContext: context) as! NSManagedObject;
            
            println(toDoOutlet.text!)
            
            todo_item.setValue("\(toDoOutlet.text!)", forKey: "toDo");
            todo_item.setValue("\(beschreibungOutlet.text!)", forKey: "beschreibung");
            todo_item.setValue("\(datumOutlet.text!)", forKey: "datum");
            
            
            context.save(nil)
            
            toDoOutlet.text = ""
            beschreibungOutlet.text = ""
            datumOutlet.text = ""
          // self.navigationController?.popToRootViewControllerAnimated(<#animated: Bool#>)
        }
    }
    
    // Implementierte Funktion von UITextFieldDelegate.
    // Reagiert auf gedrückten Return-Button innerhalb der beiden Textfelder.
    // Wichtig: Outlets müssen vorher beim ViewController als OutletDelegate registriert werden!
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("textFieldShouldReturn aufgerufen!")
        switch textField {
        case toDoOutlet:
            toDoName = toDoOutlet.text!
            beschreibungOutlet.becomeFirstResponder()
        case beschreibungOutlet:
            beschreibungName = beschreibungOutlet.text!
            datumOutlet.becomeFirstResponder()
        case datumOutlet:
            datumName = datumOutlet.text!
            datumOutlet.resignFirstResponder()
        default:
            print("Wrong case in func textFieldShouldReturn AddToDoController.")
        }
        
        return true
    }
    
    // Funktion handelt die Datenübertragung via Segue.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      /*  if segue.identifier == "savedToDoSegue" {
            let destinationController = segue.destinationViewController as! ChooseDateViewController
            destinationController.toDoName = toDoNameAsString
            destinationController.toDoDescription = toDoDescriptionAsString
            destinationController.toDoEstimatedTime = toDoEstimatedTimeAsString
        } else if segue.identifier == "SaveButton" {
            print("Segue.identifier: \(segue.identifier).")
        }*/
    }
}
