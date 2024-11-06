//
//  ClaseTableViewCell.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 27/05/20.
//  Copyright © 2020 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class ClaseTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imagenClaseMateria: UIImageView!
    
    
    @IBOutlet weak var nombreClaseMateria: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
