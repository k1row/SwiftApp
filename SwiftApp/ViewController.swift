//
//  ViewController.swift
//  SwiftApp
//
//  Created by Keiichiro Nagashima on 2014/06/05.
//  Copyright (c) 2014年 Keiichiro Nagashima. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView
    var todoObjects = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTouchAddButton(sender : AnyObject) {
        let sampleTodo: Todo = Todo.MR_createEntity() as Todo
        sampleTodo.title = "title: \(NSDate.date())"
        sampleTodo.timeStamp = NSDate.date()
        
        // CoreDataに保存
        sampleTodo.managedObjectContext.MR_saveToPersistentStoreAndWait()
        reloadData()
    }
    
    func reloadData() {
        todoObjects = Todo.MR_findAll()
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return todoObjects.count
    }
    
     func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "TodoCell")
        
        cell.text = todoObjects[indexPath.row].title
        cell.detailTextLabel.text = "\(todoObjects[indexPath.row].timeStamp)"
        
        return cell
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Entityの削除
            let todoObject: Todo = todoObjects[indexPath.row] as Todo
            todoObject.MR_deleteEntity()
            
            todoObject.managedObjectContext.MR_saveToPersistentStoreAndWait()
            
            todoObjects = Todo.MR_findAll()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    func tableView(tableView: UITableView!, editingStyleForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.Delete;
    }
}

