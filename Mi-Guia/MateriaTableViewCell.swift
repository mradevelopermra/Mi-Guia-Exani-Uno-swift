//
//  MateriaTableViewCell.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 16/05/18.
//  Copyright © 2018 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class MateriaTableViewCell: UITableViewCell {
    @IBOutlet weak var imagenMateria: UIImageView!
    
    @IBOutlet weak var nombreMateria: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
