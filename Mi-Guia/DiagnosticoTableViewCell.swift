//
//  DiagnosticoTableViewCell.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 2/5/19.
//  Copyright © 2019 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class DiagnosticoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var preguntaDiag: UILabel!
    
    
    @IBOutlet weak var pregImagen: UIImageView!
    
    @IBOutlet weak var respuestaDiag: UILabel!
    
    
    @IBOutlet weak var correctoDiag: UILabel!
    
    
    @IBOutlet weak var tooltipDiag: UILabel!
    
    
    @IBOutlet weak var tooltipImagDiag: UIImageView!
    
    
    @IBOutlet weak var imaAcierto: UIImageView!
    
    
    @IBOutlet weak var leyendaAcierto: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
