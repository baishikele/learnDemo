//
//  RXCodeViewController.swift
//  swiftDemo
//
//  Created by tanghuan on 2019/8/20.
//  Copyright © 2019 tanghuan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RXCodeViewController: UIViewController {

    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var twoField: UITextField!
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var oneField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    private let dis = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
      
        
        
//        let driver = oneField.rx.text.asDriver()
//        let observer = oneLabel.rx.text
//        _ = driver.drive(observer)
        oneField.rx.text.orEmpty.subscribe(onNext: {[weak self] (str) in
            self?.oneLabel.text = str
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        self.textSignal()
        
        self.testObserver()
        
        self.testTapVcView()
     
    }


    func testObserable() {
        
        let observable : Observable<Int> = Observable.create { (observer) -> Disposable in
            
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onCompleted()

            return Disposables.create()
        }
        
        
        observable.subscribe(onNext: { (num) in
             print(num)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    func textSignal() -> Void {
        
       
//        let ab : Observable<Bool> = Observable.create {[weak self] (ab) -> Disposable in
//
//            if self?.oneField.text?.count ?? 0 > 3 {
//                ab.onNext(true)
//
//            }else{
//                ab.onNext(false)
//
//            }
//
//
//            return Disposables.create()
//        }
        

//        _ = ab.subscribe(onNext: {[weak self] (result) in
//
//            if result == true {
//                self?.oneLabel.textColor = UIColor.red
//
//            }else{
//                self?.oneLabel.textColor = UIColor.green
//
//            }
//        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        let ab = oneField.rx.text.asObservable()
        
        ab.subscribe(onNext: {[weak self] (str) in
            if let s = str{
                if s.count > 3{
                    self?.oneLabel.textColor = UIColor.red

                }else{
                    self?.oneLabel.textColor = UIColor.green

                }
                
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)


    }
    
    
    func testObserver() -> Void {
        
        let observer : AnyObserver<Bool> = AnyObserver { [weak self] (event) in
            
            switch event{
            case .next(let ishidden):
                self?.twoLabel.isHidden = ishidden

            case .error(_):
                print("error")
            case .completed:
                print("completed")
            }
            
        }
        
//        twoField.rx.text.orEmpty.map{
//                $0.count > 2
//            }.bind(to: observer).disposed(by: self.dis)
        
        twoField.rx.text.orEmpty.map{
            $0.count > 2
        }.subscribe(observer).disposed(by: self.dis)
        
        
    }
    
    


    func testImage() {
        let image : Observable<UIImage> = Observable.create { (observer) -> Disposable in
            let i = UIImage(named: "accessSystemFunc_logo@2x")
            observer.onNext(i ?? UIImage())
            return Disposables.create()
        }
        
        
        _ = image.bind(to: imageView.rx.image)
        
    }
    
    
    func testTapVcView() -> Void {
        let tap = UITapGestureRecognizer()
        self.view.addGestureRecognizer(tap)
        tap.rx.event.subscribe(onNext: { (tap) in
            self.view.endEditing(true)
            
            self.testObserable()
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    
    
}
