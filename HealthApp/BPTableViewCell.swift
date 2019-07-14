//
//  BPTableViewCell.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 14/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class BPTableViewCell: UITableViewCell {

    @IBOutlet weak var outLabelDate: UILabel!
    
    @IBOutlet weak var outLabelMorningBP: UILabel!
    
    @IBOutlet weak var outLabelAfternoonBP: UILabel!
    
    @IBOutlet weak var outLabelEveningBP: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
