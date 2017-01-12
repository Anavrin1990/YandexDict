//
//  MainTableViewCell.swift
//  YandexDict
//
//  Created by Dmitry on 09.01.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    @IBOutlet weak var langLabel: UILabel!
        
    @IBOutlet weak var synValue: UILabel!
    @IBOutlet weak var meanValue: UILabel!
    @IBOutlet weak var meanKey: UILabel!
    @IBOutlet weak var synKey: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
