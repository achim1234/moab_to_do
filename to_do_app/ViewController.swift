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
    var daten = [ToDo]();
    
    var toDoTitlesFromCoreData = [String]()
    
    override func viewDidAppear(animated: Bool) {
        //loadData();
        println("view Did appear");
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
                //var descrAsString:String = descr as! String
                //var dateAsString:String = doDate as! String
             
                
                toDoTitlesFromCoreData += [nameAsString]
            }
            println("Anzahl ToDos")
            println(toDoTitlesFromCoreData.count)
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
        return toDoTitlesFromCoreData.count;
        // return daten.count;
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCellWithIdentifier("toDoCell", forIndexPath: indexPath) as! UITableViewCell //crash!!!!!!!!!
        
        cell.textLabel?.text = "\(toDoTitlesFromCoreData[indexPath.row])";
        
        println("toDoTitles in TableView")
        println("\(toDoTitlesFromCoreData[indexPath.row])")
        
        return cell;
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //if(segue.identifier == "segue_show_todo"){
          //  (segue.destinationViewController as! ShowToDo).todo_item = daten[tableView.indexPathForCell(sender as! UITableViewCell)!.row];
        //}
    }
    
    
    
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true;
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            context!.deleteObject(daten[indexPath.row]);
            context!.save(nil);
            let fetchRequest = NSFetchRequest(entityName: "ToDos");
            daten = context!.executeFetchRequest(fetchRequest, error: nil) as! [ToDo];
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    

    
    
    
    
}

