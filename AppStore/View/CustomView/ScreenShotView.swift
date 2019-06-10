//
//  ScreenShotView.swift
//  AppStore
//
//  Created by azsha on 04/06/2019.
//  Copyright © 2019 Scott. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ScreenShotView: UIView {
    let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var screenShotUrlPaths: PublishSubject<[String]> = PublishSubject<[String]>()
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 16, height: 700)
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(ScreenShotCell.self, forCellWithReuseIdentifier: "ScreenShotCell")
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        screenShotUrlPaths.asObservable()
            .bind(to: collectionView.rx.items) { (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenShotCell", for: indexPath) as! ScreenShotCell
                cell.screenShotImagePath = element
                return cell
            }
            .disposed(by: disposeBag)
    }
}
