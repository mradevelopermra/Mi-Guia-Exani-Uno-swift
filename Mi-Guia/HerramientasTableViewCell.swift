//
//  HerramientasTableViewCell.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 1/28/19.
//  Copyright © 2019 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class HerramientasTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imaHerramienta: UIImageView!
    
    
    @IBOutlet weak var nomHerramienta: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
