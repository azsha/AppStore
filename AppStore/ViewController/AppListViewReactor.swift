//
//  AppListViewReactor.swift
//  AppStore
//
//  Created by azsha on 29/05/2019.
//  Copyright © 2019 Scott. All rights reserved.
//

import RxSwift
import ReactorKit
import Moya

class AppListViewReactor: Reactor {
    enum Action {
        case updateAppList
    }
    
    enum Mutation {
        case setAppList([AppData.Feed.Results])
    }
    
    struct State {
        var appList: [AppData.Feed.Results] = []
    }
    
    let provider = MoyaProvider<Appstore>()
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateAppList:
            let getAppList: Observable<Mutation> = self.getAppList().asObservable().map(Mutation.setAppList)
            
            return getAppList
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setAppList (let appList):
            newState.appList = appList
        }
        return newState
    }
    
    private func getAppList() -> Single<[AppData.Feed.Results]> {
         return provider.rx.request(.all).map { result in
            guard let responseJSON = try? JSONDecoder().decode(AppData.self, from: result.data) else { return [] }
            let appDatas = responseJSON.feed.results
            return appDatas
        }
    }
}
