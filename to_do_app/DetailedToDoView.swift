//
//  DetailedToDoView.swift
//  to_do_app
//
//  Created by as-131866 on 12.01.16.
//  Copyright (c) 2016 as-131866. All rights reserved.
//

import UIKit

class DetailedToDoView: UIViewController {
    
    @IBOutlet weak var showToDoOutlet: UILabel!
    @IBOutlet weak var showBeschreibungOutlet: UILabel!
    @IBOutlet weak var showDatumOutlet: UILabel!
    
    
    var todo_item: ToDo? //name der Swift-Datei ToDo.swift
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showToDoOutlet.text = "\(todo_item!.toDo)";
        showBeschreibungOutlet.text = "\(todo_item!.beschreibung)";
        showDatumOutlet.text = "\(todo_item!.datum)";
        
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
