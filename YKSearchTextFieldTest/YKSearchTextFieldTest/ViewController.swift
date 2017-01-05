//
//  ViewController.swift
//  YKSearchTextFieldTest
//
//  Created by xiezuan on 16/12/20.
//  Copyright © 2016年 xz. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    let tableView = UITableView()
    
    
    var dataArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.dataArray = ["项目一","项目二","项目三","项目四"]
        
        tableView.frame = CGRectMake(0, 20, ScreenWidth, ScreenHeight-20)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = SearchTableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = dataArray[indexPath.row]
        return cell!
    
    }
    



}

