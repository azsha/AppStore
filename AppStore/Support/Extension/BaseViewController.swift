//
//  BaseViewController.swift
//  AppStore
//
//  Created by azsha on 27/05/2019.
//  Copyright © 2019 Scott. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class BaseViewController: UIViewController {
    /// Network Provider
    let provider = MoyaProvider<Appstore>()
    
    /// DisposeBag (Rx)
    var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
    }
}
