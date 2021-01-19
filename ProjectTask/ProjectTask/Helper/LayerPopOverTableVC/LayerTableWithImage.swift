//
//  LayerTableWithImage.swift
//  Kumele
//
//  Created by WV-Mac4 on 20/11/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class LayerTableWithImage: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
