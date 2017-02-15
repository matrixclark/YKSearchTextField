//
//  YKSearchTextField.swift
//  YKSearchTextFieldTest
//
//  Created by xiezuan on 16/12/20.
//  Copyright © 2016年 xz. All rights reserved.
//  Swift 2.3  版本

import UIKit



public protocol YKSearchTextFieldDataSourceDelegate: NSObjectProtocol {
    func searchTextField(_ searchTextField: YKSearchTextField, numberOfRowsInSection section: Int) -> Int
    func searchTextField(_ searchTextField: YKSearchTextField, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    func searchTextField(_ searchTextField: YKSearchTextField, didSelectRowAtIndexPath indexPath: IndexPath)
    func searchTextField(_ searchTextField: YKSearchTextField, textDidChange text: String?)
    func searchTextField(_ searchTextField: YKSearchTextField, didHideTableView tableView:UITableView)
}






open class YKSearchTextField: UITextField {
    
    
    
    open weak var dataSourceDelegate: YKSearchTextFieldDataSourceDelegate? {
        didSet {
            popView.dataSourceDelegate = self.dataSourceDelegate
        }
    }
    
    
    var popView = YKSearchPopView(frame:CGRect.zero)
    
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
    fileprivate func setupTextField() {
        addTarget(self, action: #selector(YKSearchTextField.editingBegin(_:)), for:.editingDidBegin)
        addTarget(self, action: #selector(YKSearchTextField.editingChange(_:)), for:.editingChanged)
        popView.textField = self
    }
    
    
    func editingBegin(_ textField: YKSearchTextField) {
        popView.show()
    }
    
    func editingChange(_ textField: YKSearchTextField) {
        if self.dataSourceDelegate != nil {
            self.dataSourceDelegate?.searchTextField(textField, textDidChange: textField.text)
        }
    }
    
    
}
