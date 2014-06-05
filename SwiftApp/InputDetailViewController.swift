//
//  InputDetailViewController.swift
//  SwiftApp
//
//  Created by Keiichiro Nagashima on 2014/06/05.
//  Copyright (c) 2014年 Keiichiro Nagashima. All rights reserved.
//

import UIKit

class InputDetailViewController: UIViewController {
    
    @IBOutlet var titleTextField : UITextField

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTouchDoneButton(sender : AnyObject) {
        if titleTextField.text.isEmpty {
            let alertView: UIAlertView = UIAlertView()
            alertView.title = "エラー"
            alertView.message = "タイトルが入力されていません"
            alertView.addButtonWithTitle("閉じる")
            alertView.show()
            return
        }
        
        // Entityを追加
        let sampleTodo: Todo = Todo.MR_createEntity() as Todo
        sampleTodo.title = titleTextField.text
        sampleTodo.timeStamp = NSDate.date()
        
        // CoreDataに保存
        sampleTodo.managedObjectContext.MR_saveToPersistentStoreAndWait()
        
        self.navigationController.popViewControllerAnimated(true)
    }
}
