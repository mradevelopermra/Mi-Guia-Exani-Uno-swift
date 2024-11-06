//
//  DiagnosticoExamenTableViewCell.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 2/5/19.
//  Copyright © 2019 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class DiagnosticoExamenTableViewCell: UITableViewCell {

    
    @IBOutlet weak var preguntaDiag: UILabel!
    
    @IBOutlet weak var pregImaDi: UILabel!
    
    
    @IBOutlet weak var respuestaDiag: UILabel!
    
    @IBOutlet weak var correctaDiag: UILabel!
    
    
    @IBOutlet weak var tooltipDiag: UILabel!
    
    

    @IBOutlet weak var imaTooltipDi: UILabel!
    
    @IBOutlet weak var aciertoDiag: UILabel!
    
    @IBOutlet weak var aciertoImagenDiag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
