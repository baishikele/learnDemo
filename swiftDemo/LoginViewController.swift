//
//  LoginViewController.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/15.
//  Copyright © 2019 tanghuan. All rights reserved.
//

import UIKit
import RxSwift
import URLNavigator

class LoginViewController: UIViewController {

    @IBOutlet weak var routBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var vPassWord: UILabel!
    @IBOutlet weak var vUserName: UILabel!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var userName: UITextField!
    let dis = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        _ = tap.rx.event.subscribe(onNext: {[weak self] (tap) in
            self?.view.endEditing(true)
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
      
        _ = loginBtn.rx.tap.subscribe(onNext: { () in
            print("点击登录")
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        
        // 用户名是否有效
        let usernameValid = userName.rx.text.orEmpty.map { $0.count >= 3
        }.share(replay: 1)
        
        // 用户名是否有效 -> 密码输入框是否可用
        usernameValid.bind(to: passWord.rx.isEnabled).disposed(by: dis)
        
        // 用户名是否有效 -> 用户名提示语是否隐藏
        usernameValid.bind(to: vUserName.rx.isHidden).disposed(by: dis)
        
        // 密码是否有效
        let passwordValid = passWord.rx.text.orEmpty.map { $0.count >= 2
        }.share(replay: 1)
        
        // 密码是否有效 -> 密码提示语是否隐藏
        passwordValid.bind(to: vPassWord.rx.isHidden).disposed(by: dis)
        
        
        // 所有输入是否有效
        let everythingValid = Observable.combineLatest(
            usernameValid,
            passwordValid
        ) { $0 && $1 } // 取用户名和密码同时有效
            .share(replay: 1)
        
        
        // 所有输入是否有效 -> 绿色按钮是否可点击
        everythingValid
            .bind(to: loginBtn.rx.isEnabled)
            .disposed(by: dis)
        
        
        _ = routBtn.rx.tap.subscribe(onNext: {
            
            let view = UIView()
            view.backgroundColor = UIColor.red
            Router.shared.open(url: "jumeimall://mine?a=1&b=2",  context: view)
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
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
