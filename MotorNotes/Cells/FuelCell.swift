//
//  FuelCell.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/29/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit

class FuelCell: UITableViewCell {
    
    @IBOutlet weak var fuelImageView: UIImageView!
    @IBOutlet weak var fuelRecordTitleLabel: UILabel!
    @IBOutlet weak var fuelGallonsFilledLabel: UILabel!
    @IBOutlet weak var fuelTotalCostLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
