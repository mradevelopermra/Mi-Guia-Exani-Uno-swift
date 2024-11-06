//
//  ResultadosDiagnosticoTableViewCell.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 2/6/19.
//  Copyright © 2019 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class ResultadosDiagnosticoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagenMateria: UIImageView!
    
    
    @IBOutlet weak var nombreMateria: UILabel!
    

    
    @IBOutlet weak var resultadoMateria: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
