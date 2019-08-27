//
//  DouYinViewController.swift
//  swiftDemo
//  Created by tanghuan on 2019/8/23.
//  Copyright © 2019 tanghuan. All rights reserved.
//

let offsetYBeginToRefresh = CGFloat(80)

import UIKit
import MJRefresh
import SnapKit

class DouYinViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var navBarViewTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var circleImageView: UIView!
    
    @IBOutlet weak var tableView: NotFirstResponderBaseTableView!
    private var startY: CGFloat?
    private var isRefreshing = false
    private var dataArray : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.isPagingEnabled = true
        self.tableView.responsDelegate = self
        self.tableView.estimatedRowHeight = 0.01
        
        self.dataArray.append("我")
        self.dataArray.append("是")
        self.dataArray.append("大")

        self.tableView.th_footer = DouYinFooterView.xibInitWithName(name: "DouYinFooterView", height: 40, beginToLoad: {
            print("开始加载更多拉")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.dataArray.append("好")
                self.dataArray.append("人")
                self.tableView.reloadData()
                self.tableView.th_footer?.endLoadMore()

            })
          
        })
    
        
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "DouYinCellID") ?? UITableViewCell()
        let s = self.dataArray[indexPath.row]
        cell.textLabel?.text = s+" "+String(indexPath.row)
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height
    }

    

}

extension DouYinViewController: tableViewResponsProtocal {
    
    
    func responseTouchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.tableView.contentOffset.y <= 0, self.isRefreshing == false{
            
            let startPoint = touches.first?.location(in: self.view)
            startY = startPoint?.y
        }
    }
    
    func responseTouchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("responseTouchesMoved")

        if self.isRefreshing == true {return}
        
        let currentPoint = touches.first?.location(in: self.view)
       
        guard let curPoint = currentPoint else { return }
        
        let prePoint = touches.first?.previousLocation(in: self.view)

        if tableView.contentOffset.y < 0 {
          
                if curPoint.y > prePoint?.y ?? 0 {
                    print("整体下拉，继续下拉，触发刷新前")
                    self.navBarViewTopConstrain.constant += (curPoint.y - (prePoint?.y ?? CGFloat(0)))
                    self.circleImageView.transform = self.circleImageView.transform.rotated(by: 0.08)
                }else{
                    print("整体下拉，又上拉，触发刷新前")
                    self.navBarViewTopConstrain.constant -= ((prePoint?.y ?? CGFloat(0)) - curPoint.y)
                    self.circleImageView.transform = self.circleImageView.transform.rotated(by: -0.08)

                }
            
            if self.navBarViewTopConstrain.constant > offsetYBeginToRefresh{
                self.navBarViewTopConstrain.constant = offsetYBeginToRefresh
            }
    
        }else{

            if  self.tableView.contentOffset.y > (self.tableView.contentSize.height - UIScreen.main.bounds.size.height + 40){
                print("显示加载更多")

                self.tableView.th_footer?.beginToLoadMore()
            }
        }
        if self.navBarViewTopConstrain.constant < 30{
            self.navBarViewTopConstrain.constant = 30
            
        }
        self.navBarView.layoutIfNeeded()
    }
    
    func responseTouchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("responseTouchesEnded")
        
        if self.isRefreshing == true {return}
        
            if tableView.contentOffset.y < 0 {
                
                UIView.animate(withDuration: 1) {
                    
                    if -self.tableView.contentOffset.y < offsetYBeginToRefresh {

                        self.navBarViewTopConstrain.constant = 30
                        
                    }else{
                        self.isRefreshing = true

                        self.navBarViewTopConstrain.constant = offsetYBeginToRefresh
                        self.addLayerAnimationTranformRotationX(layer: self.circleImageView.layer)

                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                
                            UIView.animate(withDuration: 1, animations: {
                                self.navBarViewTopConstrain.constant = 30
                                self.navBarView.layoutIfNeeded()
                                
                            },completion: { (_) in
                            self.circleImageView.layer.removeAllAnimations()
                                self.isRefreshing = false

                            })
                        })
                    }
                }
               
         
            }
//            else if self.tableView.contentOffset.y > (self.tableView.contentSize.height - UIScreen.main.bounds.size.height + 40){
//                print("触发加载更多")
//                
//            }

    }
    
    func responseTouchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("responseTouchesCancelled")

    }
    
    
    
    
    
    func addLayerAnimationTranformRotationX(layer: CALayer) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        //旋转180度 = PI
        animation.toValue = Double.pi
        animation.duration = 2
        animation.repeatCount = MAXFLOAT
        //这里我们可以添加可以不添加，添加一个缓慢进出的动画效果(int/out)。当不添加时，匀速运动，会使用kCAMediaTimingFunctionLinear；当添加时，layer会在开始和结束时比较缓慢
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(animation, forKey: "addLayerAnimationTranformRotationX")
    }
    

}
