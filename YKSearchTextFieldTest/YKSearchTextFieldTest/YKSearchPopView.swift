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

let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height

class YKSearchPopView: UIView {

    weak var textField:YKSearchTextField?
    weak var textFieldSuperView:UIView?
    weak var dataSourceDelegate: YKSearchTextFieldDataSourceDelegate?
    
    var contentView = UIView()
    var tableView = UITableView()
    var cancelButton = UIButton(type:.custom)
    var isShow = false
    
    
    
    //originTextField status
    
    var originBorderWidth:CGFloat?
    var originBorderColor:CGColor?
    var originBackgroundColor:UIColor?
    var originCornerRadius:CGFloat?
    var originCornerLeftView:UIView?
    var originFrame:CGRect? = CGRect.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(contentView)
        self.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        contentView.backgroundColor = kYKSContentBackgroundColor
        contentView.frame = CGRect(x: 0,y: 0,width: ScreenWidth,height: ScreenHeight)
        contentView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 64, width: ScreenWidth,height: ScreenHeight-64)
        tableView.backgroundColor = UIColor.white
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()

        cancelButton.frame = CGRect(x: ScreenWidth-55, y: 27, width: 50, height: 30)
        cancelButton.setTitle("取消", for: UIControlState())
        cancelButton.setTitleColor(kYKSButtonColor, for: UIControlState())
        contentView.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: UIControlEvents.touchUpInside)
        self.isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
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
        textField?.layer.borderColor = kYKSBorderColor.cgColor
        textField?.layer.borderWidth = 1
        textField?.layer.cornerRadius = 5
        textField?.backgroundColor = UIColor.white
        if textField?.leftView == nil {
            textField?.leftView = UIView(frame:CGRect(x: 0,y: 0,width: 5,height: 30))
            textField?.leftViewMode = .always
        }
        
               //将textField放到popView上
        if let superview = textField?.superview {
            textFieldSuperView = superview
            let frame = superview.convert((textField?.frame)!, to: self)
            originFrame = frame
            textField?.removeFromSuperview()
            textField?.frame = originFrame!
            self.addSubview(textField!)
            
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.alpha = 1
            self.textField?.frame = CGRect(x: 10, y: 27, width: ScreenWidth - 70, height: 30)
            
        }, completion: { [weak self](finish:Bool) in
            self?.textField?.becomeFirstResponder()
        }) 
        
    }

    
    
    
    func dismiss() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.alpha = 0.0;
            self.textField?.frame = self.originFrame!
            
        }, completion: { [weak self](finish:Bool) in
         
            self?.textField?.layer.borderColor = self?.originBorderColor
            self?.textField?.layer.borderWidth = (self?.originBorderWidth)!
            self?.textField?.layer.cornerRadius = (self?.originCornerRadius)!
            self?.textField?.backgroundColor = self?.originBackgroundColor
            let frame = self?.convert((self?.textField?.frame)!, to: self?.textFieldSuperView!)
            self?.textField?.removeFromSuperview()
            self?.textField?.frame = frame!
            self?.textFieldSuperView?.addSubview((self?.textField)!)
            self?.removeFromSuperview()
            self?.textField?.resignFirstResponder()
            self?.textField?.leftView = self?.originCornerLeftView
            self?.isShow = false
        }) 
    }
    
    
    
    
   


    func addToCurrentWindow() {
        var currentWindow:UIWindow?
        for window in UIApplication.shared.windows {
            if window.windowLevel == UIWindowLevelNormal && window.isHidden == false {
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
    
    
    func addToView(_ window:UIWindow){
        if self.superview != nil {
            self.removeFromSuperview()
        }
        
        window.addSubview(self)
        window.bringSubview(toFront: self)
    }
    
    //MARK: - Event 
    //取消
    func cancelButtonAction(){
        dismiss()
    }
    
    
    
    

}



// Mark: UITableViewDataSoruce
extension YKSearchPopView: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSourceDelegate = dataSourceDelegate {
            return dataSourceDelegate.searchTextField(textField!, numberOfRowsInSection:section)
        }
        return 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dataSourceDelegate = dataSourceDelegate {
            return dataSourceDelegate.searchTextField(textField!, cellForRowAtIndexPath: indexPath)
            
        }
        return UITableViewCell()
    }
}

// Mark: UITableViewDelegate
extension YKSearchPopView: UITableViewDelegate {
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataSourceDelegate = dataSourceDelegate {
            dataSourceDelegate.searchTextField(textField!, didSelectRowAtIndexPath: indexPath)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss()

      //  self.tableViewAppearanceChange(false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = kYKSTitleColor
    }
}
