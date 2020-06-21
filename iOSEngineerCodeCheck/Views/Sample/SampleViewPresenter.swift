//
//  SampleViewPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

protocol SampleViewPresenterProtocol {
    var view: SampleViewPresenterOutput! { get set }
}

protocol SampleViewPresenterOutput {
    
}

final class SampleViewPresenter: SampleViewPresenterProtocol, SampleModelOutput {
    var view: SampleViewPresenterOutput!
    private var model: SampleModelProtocol
    
    init(model: SampleModelProtocol) {
        self.model = model
    }
}
