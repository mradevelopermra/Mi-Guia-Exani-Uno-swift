//
//  ResulExamenTableViewCell.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 1/29/19.
//  Copyright © 2019 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class ResulExamenTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imagenResExa: UIImageView!
    
    
    @IBOutlet weak var fechaResExa: UILabel!
    
    
    @IBOutlet weak var aciertosResExa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
