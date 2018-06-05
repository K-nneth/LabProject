//
//  PizzaTableViewCell.swift
//  ProjectLab
//
//  Created by prk on 5/31/18.
//  Copyright © 2018 prk. All rights reserved.
//

import UIKit

class PizzaTableViewCell: UITableViewCell {

    @IBOutlet weak var pizzaPrice: UILabel!
    @IBOutlet weak var pizzaName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
