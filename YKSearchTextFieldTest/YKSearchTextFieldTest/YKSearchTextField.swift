//
//  YKSearchTextField.swift
//  YKSearchTextFieldTest
//
//  Created by xiezuan on 16/12/20.
//  Copyright © 2016年 xz. All rights reserved.
//  Swift 2.3  版本

import UIKit



public protocol YKSearchTextFieldDataSourceDelegate: NSObjectProtocol {
    func searchTextField(searchTextField: YKSearchTextField, numberOfRowsInSection section: Int) -> Int
    func searchTextField(searchTextField: YKSearchTextField, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    func searchTextField(searchTextField: YKSearchTextField, didSelectRowAtIndexPath indexPath: NSIndexPath)
    func searchTextField(searchTextField: YKSearchTextField, didHideTableView tableView:UITableView)
}






public class YKSearchTextField: UITextField {


    
    public weak var dataSourceDelegate: YKSearchTextFieldDataSourceDelegate? {
        didSet {
           popView.dataSourceDelegate = self.dataSourceDelegate
        }
    }
    
    
    var popView = YKSearchPopView(frame:CGRectZero)
    
    // MARK: Init Methods
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    
    // MARK: Setup Methods
    private func setupTextField() {
        addTarget(self, action: #selector(YKSearchTextField.editingBegin(_:)), forControlEvents:.EditingDidBegin)
        popView.textField = self
    }
    
    
    

    func editingBegin(textField: UITextField) {
         popView.show()
    }
    

}
