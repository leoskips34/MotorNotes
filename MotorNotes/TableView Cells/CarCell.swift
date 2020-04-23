//
//  CarCell.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/22/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {

    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNicknameLabel: UILabel!
    @IBOutlet weak var carOdometerLabel: UILabel!
    @IBOutlet weak var carRegistrationDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
