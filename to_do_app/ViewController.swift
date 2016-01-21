//
//  ViewController.swift
//  to_do_app
//
//  Created by as-131866 on 12.01.16.
//  Copyright (c) 2016 as-131866. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    @IBOutlet var tableViewOutlet: UITableView!
    
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext;
    
    var daten = [String: [String: String]]();
    var datenMitIndexPathAlsKey = [String: [String: String]]();
    
    var dictKeyIdentifier: Int = Int.init()
    
    var segueActive: Bool = false
    
    
    override func viewDidAppear(animated: Bool) {
        //loadData();
        //println("view Did appear");
    }
    
    
    func loadData(){
        
        //var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        //var context:NSManagedObjectContext! = appDel.managedObjectContext;
        
        /*
        var request = NSFetchRequest(entityName: "ToDos");
        //request.returnsObjectsAsFaults = false;
        
        daten = context!.executeFetchRequest(request, error: nil) as! [ToDo];
        println(daten[0].beschreibung)
        
        tableView.reloadData();
        if daten.count > 0 {
            //var res = daten[0] as! NSManagedObject;
            
            println("es wurden daten geladen, ausgabe beim laden:");
            println(daten.count);
            
        }else{
            println("keine Daten");
        }
        println(" load data aufgerufen")
        tableView.reloadData();
        println("load data 2 aufgerufen")
        */
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
       
        let request = NSFetchRequest(entityName: "ToDos")
        var results = context.executeFetchRequest(request, error: nil)
        //println(results?.count)
        if results!.count > 0 {
            for item in results as! [NSManagedObject] {
                let name: AnyObject? = item.valueForKey("toDo")
                let descr: AnyObject? = item.valueForKey("beschreibung")
                let doDate: AnyObject? = item.valueForKey("datum")
                
                var nameAsString:String = name as! String
                var descrAsString:String = descr as! String
                var dateAsString:String = doDate as! String
             
                daten[nameAsString] = ["toDoName": nameAsString,
                    "toDoDescr": descrAsString,
                    "toDoDate": dateAsString]
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData();
        tableView.reloadData();
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        println("view did load aufgerufen")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return daten.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCellWithIdentifier("toDoCell", forIndexPath: indexPath) as! UITableViewCell //crash!!!!!!!!!
        
        let key = Array(self.daten.keys)[indexPath.row]
        let value = Array(self.daten.values)[indexPath.row]
        
        let indexPathAsString = String(indexPath.row)
        datenMitIndexPathAlsKey[indexPathAsString] = value
        
        cell.textLabel?.text = key
        
        
        return cell;
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "showDetailsSegue"){
            let destinationController = segue.destinationViewController as! DetailedToDoView
            destinationController.coreDataIdentifier = dictKeyIdentifier
            destinationController.coreDataHandedOver = datenMitIndexPathAlsKey
            println("prepareForSegue")
        }
    }

    
    
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true;
    }
    
    // Reagiert wenn eine Zelle angewählt wurde.
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Selected cell at indexPath.row = \(indexPath.row).")
        
        // Idee: performSegueWithIdentifier (manueller Segue mit indexPath.row).
        println("Identifier is being changed")
        dictKeyIdentifier = indexPath.row
        println("performSegueWithIdentifier")
        performSegueWithIdentifier("showDetailsSegue", sender: self)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        println("should perform segue")
        segueActive = true
        
        if identifier == "showDetailsSegue" {
            segueActive = false
        }
        
        return segueActive
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            
            let nameOfDeltedToDo = datenMitIndexPathAlsKey["\(indexPath.row)"]!["toDoName"]
            if (deleteEntryInDatabase(nameOfDeltedToDo!)) {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
            self.tableView.reloadData()
            
            /*
            // Delete the row from the data source
            //context!.deleteObject(daten[indexPath.row]);
            context!.save(nil);
            let fetchRequest = NSFetchRequest(entityName: "ToDos");
            //daten = context!.executeFetchRequest(fetchRequest, error: nil) as! [ToDo];
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            */
            
        }
    }
    
    func deleteEntryInDatabase(toDoNameToDelete: String) -> Bool {
        var flag = false;
        // Zugriff auf CoreData.
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // ManagedObjectContext verwaltet sämtliche Datenobjekte.
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        // Daten aus CoreData abfragen.
       
        // Request an die Entity "ToDos".
        let request = NSFetchRequest(entityName: "ToDos")
        // Rückgabewerte des Requests.
        let results = context.executeFetchRequest(request, error: nil)
        
        if results!.count > 0 {
            for item in results as! [NSManagedObject] {
                let name: AnyObject? = item.valueForKey("toDo")
                let descr: AnyObject? = item.valueForKey("beschreibung")
                let doDate: AnyObject? = item.valueForKey("datum")
                
                var nameAsString:String = name as! String
                var descrAsString:String = descr as! String
                var dateAsString:String = doDate as! String
                
                daten[nameAsString] = ["toDoName": nameAsString,
                    "toDoDescr": descrAsString,
                    "toDoDate": dateAsString]
        
        // Vergleich der aktuellen toDo mit zu löschender toDo
                if daten[nameAsString]!["toDoName"]! == toDoNameToDelete {
                    daten.removeValueForKey(toDoNameToDelete)
                    context.deleteObject(item)
                        if item.deleted {
                            print("ToDo \"\(toDoNameToDelete)\" successfully deleted.")
                            context.save(nil)
                            flag = true
                        }
    
                }
            
            }
        }
        return flag
    }
    
}

