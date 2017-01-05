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
        return self.dataArray.count
    }
    
    func searchTextField(searchTextField: YKSearchTextField, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = searchTextField.popView.tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = dataArray[indexPath.row]
        cell?.textLabel?.numberOfLines = 0;
        cell?.textLabel?.font = UIFont.systemFontOfSize(14)
        
        return cell!
    }
    
    
    func searchTextField(searchTextField: YKSearchTextField, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 
        textField.text = dataArray[indexPath.row]
    }
    
    
    func searchTextField(searchTextField: YKSearchTextField, didHideTableView tableView:UITableView) {
        
    }

    

}
