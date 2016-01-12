//
//  ViewController.swift
//  to_do_app
//
//  Created by as-131866 on 12.01.16.
//  Copyright (c) 2016 as-131866. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet var tableViewOutlet: UITableView!
    
    var toDos = ["Basketball spielen", "Aufstehen", "Fotografieren"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Zelle innerhalb der TableView bei der TableView selbst registrieren
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "toDoCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Vorab registrierte Klasse holen
        let cell = tableViewOutlet.dequeueReusableCellWithIdentifier("toDoCell") as! UITableViewCell
        // Array-Eintrag jeweils in Cell speichern
        cell.textLabel?.text = toDos[indexPath.row]
        
        return cell
    }
    
    // Reagiert wenn eine Zelle angewählt wurde.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print("Selected cell at indexPath.row = \(indexPath.row).")
        
        // Idee: performSegueWithIdentifier (manueller Segue mit indexPath.row).
       
        performSegueWithIdentifier("showDetailsSegue", sender: self)
    }
    
    // Diese Funktion setzt die entsprechende Zelle/Reihe auf editierbar.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Mit dieser Funktion kann man auf die Delete/Edit-Anweisungen reagieren.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("Deleting cell at indexPath.row = \(indexPath.row).")
            
      //      let nameOfDeletedToDo = dataFromCoreDataWithIndexPathAsKey["\(indexPath.row)"]!["toDoName"]!
      //      deleteEntryInDatabase(nameOfDeletedToDo)
            //fetchDatabase()
            self.tableViewOutlet.reloadData()
            
            // Versuch Daten aus CoreData wieder zu löschen.
            /* http://www.learncoredata.com/create-retrieve-update-delete-data-with-core-data/
            // 2
            let appDelegateOnDelete = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedObjContext = appDelegateOnDelete.managedObjectContext
            
            // 3
            managedObjContext.deleteObject(dataFromCoreData[indexPath.row])
            appDelegateOnDelete.saveContext()
            
            // 4
            dataFromCoreData.removeAtIndex(indexPath.row)
            tableView.reloadData()
            */
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailsSegue" {
   //         let destinationControllerShowDetails = segue.destinationViewController as! ShowDetailsViewController
     //       destinationControllerShowDetails.indexPathHandedOver = dictKeyIdentifier
       //     destinationControllerShowDetails.dataFromCoreDataHandedOver = dataFromCoreDataWithIndexPathAsKey
        }
    }
    
    
    

}

