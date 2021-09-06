//
//  TypiCodeCellViewModel.swift
//  SampleMVVMApp
//
//  Created by Hammad Zafar on 05/09/2021.
//

import UIKit

struct TypiCodeDataCellViewModel {
    
    let title : String
    let thumbnailUrl : String
    
    init(with model : TypiCodeDataModel) {
        self.title = model.title
        self.thumbnailUrl = model.thumbnailUrl
    }
}


