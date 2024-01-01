//
//  TeamCellTableViewCell.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 26/12/23.
//

import UIKit

class TeamCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamLabelName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
