//
//  SearchTableViewCell.swift
//  YKSearchTextFieldTest
//
//  Created by xiezuan on 16/12/21.
//  Copyright © 2016年 xz. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell,YKSearchTextFieldDataSourceDelegate {
    
    
    let textField = YKSearchTextField()
    
    var dataArray = [String]()
    var filterArray = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected( selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.dataArray = ["北京","广州","上海","深圳"]
        self.filterArray.appendContentsOf(self.dataArray)
        
        textField.dataSourceDelegate = self
        textField.frame = CGRectMake(70, 7, ScreenWidth - 80, 30)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.greenColor().CGColor
        self.addSubview(textField)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func searchTextField(searchTextField: YKSearchTextField, numberOfRowsInSection section: Int) -> Int {
        return self.filterArray.count
    }
    
    func searchTextField(searchTextField: YKSearchTextField, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = searchTextField.popView.tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = filterArray[indexPath.row]
        cell?.textLabel?.numberOfLines = 0;
        cell?.textLabel?.font = UIFont.systemFontOfSize(14)
        
        return cell!
    }
    
    
    func searchTextField(searchTextField: YKSearchTextField, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 
        textField.text = filterArray[indexPath.row]
    }
    
    
    func searchTextField(searchTextField: YKSearchTextField, didHideTableView tableView:UITableView) {
        
    }
    
    
    func searchTextField(searchTextField: YKSearchTextField, textDidChange text: String?) {
        self.filterArray.removeAll()
        if text?.characters.count > 0 {
            for string in self.dataArray {
                if string.containsString(text!) {
                    self.filterArray.append(string)
                }
            }
            
        }else{
            
            self.filterArray.appendContentsOf(self.dataArray)
        }
        
        textField.popView.tableView.reloadData()
        
    }

    

}
