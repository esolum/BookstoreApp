//
//  LibraryTableViewCell.swift
//  Bookstore
//
//  Created by Erica Solum on 11/24/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var authorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
