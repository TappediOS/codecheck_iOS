//
//  FetchedDataShowModel.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/23.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol FetchedDataShowModelProtocol {
    var presenter: FetchedDataShowModelOutput! { get set }
}

protocol FetchedDataShowModelOutput {
    
}

final class FetchedDataShowModel: FetchedDataShowModelProtocol {
    var presenter: FetchedDataShowModelOutput!
}
