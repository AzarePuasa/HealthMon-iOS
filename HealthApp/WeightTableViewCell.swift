//
//  WeightTableViewCell.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 11/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class WeightTableViewCell: UITableViewCell {

    @IBOutlet weak var outDate: UILabel!
    
    @IBOutlet weak var outWeightRecord: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
