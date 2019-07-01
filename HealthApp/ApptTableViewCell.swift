//
//  ApptTableViewCell.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 28/5/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class ApptTableViewCell: UITableViewCell {

    @IBOutlet weak var outDate: UILabel!
    
    @IBOutlet weak var outTime: UILabel!
    
    @IBOutlet weak var outLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
