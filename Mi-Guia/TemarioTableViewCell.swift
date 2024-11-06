//
//  TemarioTableViewCell.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 27/05/20.
//  Copyright © 2020 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class TemarioTableViewCell: UITableViewCell {

    
    @IBOutlet weak var temaClase: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
