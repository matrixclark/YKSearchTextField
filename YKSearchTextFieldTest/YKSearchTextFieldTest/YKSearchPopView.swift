//
//  YKSearchPopView.swift
//  YKSearchTextFieldTest
//
//  Created by xiezuan on 16/12/20.
//  Copyright © 2016年 xz. All rights reserved.
//  Swift 2.3  版本

import UIKit

let kYKSContentBackgroundColor =  UIColor(colorLiteralRed: 239.0/255, green: 239.0/255, blue: 244.0/255,alpha: 1.0)
let kYKSButtonColor =  UIColor(colorLiteralRed: 58.0/255, green: 137.0/255, blue: 255.0/255,alpha: 1.0)
let kYKSBorderColor =  UIColor(colorLiteralRed: 218.0/255, green: 229.0/255, blue: 223.0/255,alpha: 1.0)
let kYKSTitleColor =  UIColor(colorLiteralRed: 52.0/255, green: 52.0/255, blue: 52.0/255,alpha: 1.0)

let ScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
let ScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height

class YKSearchPopView: UIView {

    weak var textField:YKSearchTextField?
    weak var textFieldSuperView:UIView?
    weak var dataSourceDelegate: YKSearchTextFieldDataSourceDelegate?
    
    var contentView = UIView()
    var tableView = UITableView()
    var cancelButton = UIButton(type:.Custom)
    var isShow = false
    
    
    
    //originTextField status
    
    var originBorderWidth:CGFloat?
    var originBorderColor:CGColor?
    var originBackgroundColor:UIColor?
    var originCornerRadius:CGFloat?
    var originCornerLeftView:UIView?
    var originFrame:CGRect? = CGRectZero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(contentView)
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight)
        contentView.backgroundColor = kYKSContentBackgroundColor
        contentView.frame = CGRectMake(0,0,ScreenWidth,ScreenHeight)
        contentView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRectMake(0, 64, ScreenWidth,ScreenHeight-64)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()

        cancelButton.frame = CGRectMake(ScreenWidth-55, 27, 50, 30)
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.setTitleColor(kYKSButtonColor, forState: .Normal)
        contentView.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.userInteractionEnabled = true
        contentView.userInteractionEnabled = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func show() {
        if isShow {
            return
        }
        
        originBorderWidth = textField?.layer.borderWidth
        originBorderColor = textField?.layer.borderColor
        originCornerRadius = textField?.layer.cornerRadius
        originBackgroundColor = textField?.backgroundColor
        originFrame = textField?.frame
        originCornerLeftView = textField?.leftView
        
        addToCurrentWindow()
        animateAppearance()
        
        isShow = true
    }
    
    
    
    
    
    func animateAppearance(){
        
        self.contentView.alpha = 0.0;
        textField?.layer.borderColor = kYKSBorderColor.CGColor
        textField?.layer.borderWidth = 1
        textField?.layer.cornerRadius = 5
        textField?.backgroundColor = UIColor.whiteColor()
        if textField?.leftView == nil {
            textField?.leftView = UIView(frame:CGRectMake(0,0,5,30))
            textField?.leftViewMode = .Always
        }
        
               //将textField放到popView上
        if let superview = textField?.superview {
            textFieldSuperView = superview
            let frame = superview.convertRect((textField?.frame)!, toView: self)
            originFrame = frame
            textField?.removeFromSuperview()
            textField?.frame = originFrame!
            self.addSubview(textField!)
            
        }
        
        UIView.animateWithDuration(0.3, animations: {
            self.contentView.alpha = 1
            self.textField?.frame = CGRectMake(10, 27, ScreenWidth - 70, 30)
            
        }) { [weak self](finish:Bool) in
            self?.textField?.becomeFirstResponder()
        }
        
    }

    
    
    
    func dismiss() {
        
        UIView.animateWithDuration(0.3, animations: {
            self.contentView.alpha = 0.0;
            self.textField?.frame = self.originFrame!
            
        }) { [weak self](finish:Bool) in
         
            self?.textField?.layer.borderColor = self?.originBorderColor
            self?.textField?.layer.borderWidth = (self?.originBorderWidth)!
            self?.textField?.layer.cornerRadius = (self?.originCornerRadius)!
            self?.textField?.backgroundColor = self?.originBackgroundColor
            let frame = self?.convertRect((self?.textField?.frame)!, toView: self?.textFieldSuperView!)
            self?.textField?.removeFromSuperview()
            self?.textField?.frame = frame!
            self?.textFieldSuperView?.addSubview((self?.textField)!)
            self?.removeFromSuperview()
            self?.textField?.resignFirstResponder()
            self?.textField?.leftView = self?.originCornerLeftView
            self?.isShow = false
        }
    }
    
    
    
    
   


    func addToCurrentWindow() {
        var currentWindow:UIWindow?
        for window in UIApplication.sharedApplication().windows {
            if window.windowLevel == UIWindowLevelNormal && window.hidden == false {
                currentWindow = window
                break
            }
        }
        
        if currentWindow != nil {
            if self.superview != currentWindow {
                self.addToView(currentWindow!)
            }
        }
    }
    
    
    func addToView(window:UIWindow){
        if self.superview != nil {
            self.removeFromSuperview()
        }
        
        window.addSubview(self)
        window.bringSubviewToFront(self)
    }
    
    //MARK: - Event 
    //取消
    func cancelButtonAction(){
        dismiss()
    }
    
    
    
    

}



// Mark: UITableViewDataSoruce
extension YKSearchPopView: UITableViewDataSource {
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSourceDelegate = dataSourceDelegate {
            return dataSourceDelegate.searchTextField(textField!, numberOfRowsInSection:section)
        }
        return 0
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let dataSourceDelegate = dataSourceDelegate {
            return dataSourceDelegate.searchTextField(textField!, cellForRowAtIndexPath: indexPath)
            
        }
        return UITableViewCell()
    }
}

// Mark: UITableViewDelegate
extension YKSearchPopView: UITableViewDelegate {
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let dataSourceDelegate = dataSourceDelegate {
            dataSourceDelegate.searchTextField(textField!, didSelectRowAtIndexPath: indexPath)
        }
      //  self.tableViewAppearanceChange(false)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.textLabel?.font = UIFont.systemFontOfSize(14)
        cell.textLabel?.textColor = kYKSTitleColor
    }
}
