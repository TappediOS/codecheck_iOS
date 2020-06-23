//
//  FetchedDataShowPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

protocol FetchedDataShowViewPresenterProtocol {
    var view: FetchedDataShowViewPresenterOutput! { get set }
}

protocol FetchedDataShowViewPresenterOutput {
    
}

final class FetchedDataShowViewPresenter: FetchedDataShowViewPresenterProtocol, FetchedDataShowModelOutput {
    var view: FetchedDataShowViewPresenterOutput!
    private var model: FetchedDataShowModelProtocol
    
    init(model: FetchedDataShowModelProtocol) {
        self.model = model
    }
}

