//
//  TestTableViewViewController.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/22.
//  Copyright © 2019 tanghuan. All rights reserved.
//

import UIKit
import MJRefresh

class TestTableViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: NotFirstResponderBaseTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.isPagingEnabled = true
        self.navigationController?.isNavigationBarHidden = true
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//            self.tableView.setContentOffset(CGPoint(x: 0, y: UIScreen.main.bounds.size.height*3), animated: true)
//        }
//        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
//            
//            print("刷新中...")
//            
//            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
//                self.tableView.mj_header.endRefreshing()
//            })
//            
//        })
//        
//        
//        self.tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
//            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
//            print("加载中....")
//            self.tableView.mj_footer.endRefreshing()
//            })
//
//        })
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "testCellID") else { return UITableViewCell() }

        cell.textLabel?.text = String(indexPath.row)
        
        cell.textLabel?.backgroundColor = UIColor.init(red: CGFloat(arc4random()%250), green: CGFloat(arc4random()%250), blue: CGFloat(arc4random()%250), alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
