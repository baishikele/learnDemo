//
//  NotFirstResponderBaseTableView.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/23.
//  Copyright © 2019 tanghuan. All rights reserved.
//

import UIKit

protocol tableViewResponsProtocal {
    func responseTouchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func responseTouchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    func responseTouchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    func responseTouchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
}
class NotFirstResponderBaseTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var responsDelegate: tableViewResponsProtocal?
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 在table上重写touchesMoved，手指滑动一会儿后控制台就不再打印了，每次位移大概十几个像素，并且松手后touchesEnded方法也不怎么走。 是因为table滚动是默认有一个pan手势，手势的响应级比UIResponder高，成功识别手势后就执行了touchesCancelled，所以你收不到touchesEnded如果你设置table.panGestureRecognizer.cancelsTouchesInView = NO; Moved方法就会一直执行。
        self.panGestureRecognizer.cancelsTouchesInView = false

    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.responsDelegate?.responseTouchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.responsDelegate?.responseTouchesMoved(touches, with: event)

    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.responsDelegate?.responseTouchesEnded(touches, with: event)

    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.responsDelegate?.responseTouchesCancelled(touches, with: event)

    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return true
    }
}
