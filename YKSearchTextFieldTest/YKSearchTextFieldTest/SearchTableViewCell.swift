//
//  SearchTableViewCell.swift
//  YKSearchTextFieldTest
//
//  Created by xiezuan on 16/12/21.
//  Copyright © 2016年 xz. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class SearchTableViewCell: UITableViewCell,YKSearchTextFieldDataSourceDelegate {
    
    
    let textField = YKSearchTextField()
    
    var dataArray = [String]()
    var filterArray = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected( _ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.dataArray = ["北京","广州","上海","深圳"]
        self.filterArray.append(contentsOf: self.dataArray)
        
        textField.dataSourceDelegate = self
        textField.frame = CGRect(x: 70, y: 7, width: ScreenWidth - 80, height: 30)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.green.cgColor
        self.addSubview(textField)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func searchTextField(_ searchTextField: YKSearchTextField, numberOfRowsInSection section: Int) -> Int {
        return self.filterArray.count
    }
    
    func searchTextField(_ searchTextField: YKSearchTextField, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell = searchTextField.popView.tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = filterArray[indexPath.row]
        cell?.textLabel?.numberOfLines = 0;
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell!
    }
    
    
    func searchTextField(_ searchTextField: YKSearchTextField, didSelectRowAtIndexPath indexPath: IndexPath) {
 
        textField.text = filterArray[indexPath.row]
    }
    
    
    func searchTextField(_ searchTextField: YKSearchTextField, didHideTableView tableView:UITableView) {
        
    }
    
    
    func searchTextField(_ searchTextField: YKSearchTextField, textDidChange text: String?) {
        self.filterArray.removeAll()
        if text?.characters.count > 0 {
            for string in self.dataArray {
                if string.contains(text!) {
                    self.filterArray.append(string)
                }
            }
            
        }else{
            
            self.filterArray.append(contentsOf: self.dataArray)
        }
        
        textField.popView.tableView.reloadData()
        
    }

    

}
