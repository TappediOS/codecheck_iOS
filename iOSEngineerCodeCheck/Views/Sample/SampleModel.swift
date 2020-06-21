//
//  SampleModel.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

protocol SampleModelProtocol {
    var presenter: SampleModelOutput! { get set }
}

protocol SampleModelOutput {
    
}

final class SampleModel: SampleModelProtocol {
    var presenter: SampleModelOutput!
}
