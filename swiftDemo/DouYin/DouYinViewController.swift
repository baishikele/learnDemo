//
//  DouYinViewController.swift
//  swiftDemo
//  Created by tanghuan on 2019/8/23.
//  Copyright © 2019 tanghuan. All rights reserved.
//

let offsetYBeginToRefresh = CGFloat(80)

import UIKit

class DouYinViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var navBarViewTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var circleImageView: UIView!
    
    @IBOutlet weak var tableView: NotFirstResponderBaseTableView!
    private var startY: CGFloat?
    private var isRefreshing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true

        self.tableView.responsDelegate = self
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "DouYinCellID") ?? UITableViewCell()
        cell.textLabel?.text = String(indexPath.row)
        
        cell.textLabel?.backgroundColor = UIColor.init(red: CGFloat(arc4random()%250), green: CGFloat(arc4random()%250), blue: CGFloat(arc4random()%250), alpha: 1)
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
       
        guard let startY = self.startY, let curPoint = currentPoint else { return }

        let moveDistance = curPoint.y - startY
        
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
            print("上拉")

        }
        if self.navBarViewTopConstrain.constant < 30{
            self.navBarViewTopConstrain.constant = 30
            
        }
        self.navBarView.layoutIfNeeded()
    }
    
    func responseTouchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("responseTouchesEnded")
        
        if self.isRefreshing == true {return}
        
            let currentPoint = touches.first?.location(in: self.view)
        
            if tableView.contentOffset.y < 0 {
                
                guard let curPoint = currentPoint else { return }
                
                UIView.animate(withDuration: 1) {
                    if curPoint.y - (self.startY ?? CGFloat(0)) < offsetYBeginToRefresh-30{
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

    }
    
    func responseTouchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("responseTouchesCancelled")

    }
    
    
    
    
    
    func addLayerAnimationTranformRotationX(layer: CALayer) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        //旋转180度 = PI
        animation.toValue = M_PI
        animation.duration = 3
        animation.repeatCount = MAXFLOAT
        //这里我们可以添加可以不添加，添加一个缓慢进出的动画效果(int/out)。当不添加时，匀速运动，会使用kCAMediaTimingFunctionLinear；当添加时，layer会在开始和结束时比较缓慢
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(animation, forKey: "addLayerAnimationTranformRotationX")
    }
    

}
