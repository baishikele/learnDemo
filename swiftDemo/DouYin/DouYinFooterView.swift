//
//  DouYinFooterView.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/26.
//  Copyright © 2019 tanghuan. All rights reserved.
//

import UIKit

var myOptionKey = 100

class DouYinFooterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var beginToLoad: (()->())?
    var isLoading = false
   
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var flower: UIActivityIndicatorView!
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
       
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if let tableView = self.superview as? UITableView {
            
            tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
            tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)

        }
        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if self.isLoading == true {return}

        if let tableView = self.superview as? UITableView {

            if keyPath == "contentOffset"{

            }else if keyPath == "contentSize"{
                self.mj_y = tableView.mj_contentH
            }
        }
    }
    
    func beginToLoadMore() -> Void {
        if self.isLoading == true {return}
        self.beginToLoad?()
        self.isLoading = true
        self.flower.startAnimating()
        self.tipsLabel.text = "加载中..."
    }
    func endLoadMore() {
        
        self.isLoading = false
        self.flower.stopAnimating()
        self.tipsLabel.text = "准备加载"
    }
    
    static func xibInitWithName(name:String, height:CGFloat = 44, beginToLoad:@escaping (()->()))->DouYinFooterView?{

        
        if let footer = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.last as? DouYinFooterView{
            
            footer.beginToLoad = beginToLoad
            
          
            return footer
        }
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if (self.superview as? UITableView) != nil{
            self.mj_x = 0
            self.mj_h = 40
            self.mj_w = UIScreen.main.bounds.size.width
        }
    }
}

extension NotFirstResponderBaseTableView{
    
    var th_footer: DouYinFooterView? {
        set {
            if self.th_footer != newValue, let v = newValue{
                self.insertSubview(v, at: 0)
                objc_setAssociatedObject(self, &myOptionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            }
            
        }
        
        get {
            return objc_getAssociatedObject(self, &myOptionKey) as? DouYinFooterView
        }
    }
    
    
    
    
}
