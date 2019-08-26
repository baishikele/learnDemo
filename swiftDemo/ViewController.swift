//
//  ViewController.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/14.
//  Copyright © 2019 tanghuan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let dis = DisposeBag()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
     
       _ = btn.rx.tap.subscribe(onNext: {[weak self] () in
        print("\(self?.btn) button Tapped")

        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        
        
        _ = scrollView.rx.contentOffset.subscribe(onNext: { (contentOffset) in
            print("contentOffset: \(contentOffset)")

        }, onError: nil, onCompleted: nil, onDisposed: nil)

        
       


      let t = Observable<Teacher>.create { (observer) -> Disposable in
            
            DispatchQueue.main.async {
                Thread.sleep(forTimeInterval: 0.3)
                
                let t = Teacher()
                t.name = "哈哈"
                
                observer.onNext(t)
            }
            return Disposables.create()
        }
        
        
        let c = Observable<[Comment]>.create { (observer) -> Disposable in
            
            DispatchQueue.main.async {
                Thread.sleep(forTimeInterval: 0.1)
                
                let t = Comment()
                t.title = "哈哈hehe"
                
                observer.onNext([t])
//                let e = NSError.init(domain: "dmoaininfo", code: 100, userInfo: ["info": "粗错了奥"])
//                observer.onError(e)
            }
            return Disposables.create()
        }
        
        Observable.zip(
            t,
            c
            ).subscribe(onNext: { (teacher, comments) in
                print("获取老师信息成功: \(String(describing: teacher.name))")
                print("获取老师评论成功: \(comments.count) 条")
            }, onError: { error in
                print("获取老师信息或评论失败: \(error)")
            })
            .disposed(by: dis)
        
    }


}

/// 用 Rx 封装接口
enum API {
    
    /// 取得老师的详细信息
//    static func teacher(teacherId: Int) -> Observable<Teacher> {
//
//
//        Observable<Teacher>.create { (observer) -> Disposable in
//
//            DispatchQueue.main.async {
//             Thread.sleep(forTimeInterval: 0.3)
//
//                let t = Teacher()
//                t.name = "哈哈"
//
//                observer.onNext(t)
//            }
//            return Disposables.create()
//        }
//    }
    
    /// 取得老师的评论
    static func teacherComments(teacherId: Int) -> Observable<[Comment]> { print("123")
        return PublishSubject<[Comment]>()

    }
}


class Teacher {
    var name:String?
}
class Comment {
    var title:String?
    
}
