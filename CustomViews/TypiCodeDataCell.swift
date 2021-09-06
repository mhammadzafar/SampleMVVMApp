//
//  TypiCodeDataCell.swift
//  SampleMVVMApp
//
//  Created by Hammad Zafar on 05/09/2021.
//

import UIKit

class TypiCodeDataCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailUrlLabel: UILabel!
    
    static let identifier = Constants.TypiCodeDataCellIdentifier
    
    private var viewModel : TypiCodeDataCellViewModel?
    
    func configure(with viewModel: TypiCodeDataCellViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.thumbnailUrlLabel.text = viewModel.thumbnailUrl
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
