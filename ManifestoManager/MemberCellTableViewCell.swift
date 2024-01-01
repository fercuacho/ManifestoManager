//
//  MemberCellTableViewCell.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 28/12/23.
//

import UIKit

class MemberCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var MemberImage: UIImageView!
    @IBOutlet weak var memberNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
