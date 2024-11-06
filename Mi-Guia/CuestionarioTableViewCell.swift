//
//  CuestionarioTableViewCell.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 19/05/18.
//  Copyright © 2018 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class CuestionarioTableViewCell: UITableViewCell {

    @IBOutlet weak var radioRespuesta: UIImageView!
    
    @IBOutlet weak var textoRespuesta: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
