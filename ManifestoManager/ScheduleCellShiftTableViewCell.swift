//
//  ScheduleCellShiftTableViewCell.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 31/12/23.
//

import UIKit

class ScheduleCellShiftTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var sifhtLabel: UILabel!
    
    @IBOutlet weak var viewColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
