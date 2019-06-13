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
    fileprivate let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    fileprivate let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    /// ScreenShot Data
    var screenShotUrlPaths: PublishSubject<[String]> = PublishSubject<[String]>()
    
    fileprivate var disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        collectionView.rx.didEndDragging
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let position = self.collectionView.contentOffset.x
                
                guard Int(position) != 0 else { return }
                let index = Int(position + 104) / 208
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.collectionView.setContentOffset(CGPoint(x: 208 * index, y: 0), animated: false)
                })
            }).disposed(by: disposeBag)
        
        collectionView.rx.didEndDecelerating
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let position = self.collectionView.contentOffset.x
                
                guard Int(position) != 0 else { return }
                let index = Int(position + 104) / 208
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.collectionView.setContentOffset(CGPoint(x: 208 * index, y: 0), animated: false)
                })
            }).disposed(by: disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        screenShotUrlPaths
            .bind(to: collectionView.rx.items) { (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenShotCell", for: indexPath) as! ScreenShotCell
                cell.screenShotImagePath = element
                return cell
            }
            .disposed(by: disposeBag)
        
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize = CGSize(width: 196, height: 348)
        
        let inset: CGFloat = 24
        layout.sectionInset.left = inset
        layout.sectionInset.right = inset
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(ScreenShotCell.self, forCellWithReuseIdentifier: "ScreenShotCell")
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = false
    }
}
