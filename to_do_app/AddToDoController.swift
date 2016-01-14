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
            
            
            todo_item.setValue("" + "\(toDoOutlet.text)", forKey: "toDo");
            todo_item.setValue("" + "\(beschreibungOutlet.text)", forKey: "beschreibung");
            todo_item.setValue("" + "\(datumOutlet.text)", forKey: "datum");
            
            
            context.save(nil)
            
            toDoOutlet.text = ""
            beschreibungOutlet.text = ""
            datumOutlet.text = ""
           
        }
    }
}
