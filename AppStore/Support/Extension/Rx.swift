//
//  Rx.swift
//  AppStore
//
//  Created by azsha on 05/11/2018.
//  Copyright © 2018 Scott. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

extension Request: ReactiveCompatible { }

extension Reactive where Base: DataRequest {
    func responseJSON() -> Observable<Any> {
        return Observable.create({ observer in
            let request = self.base.responseData { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create(with: request.cancel)
        })
    }
}
