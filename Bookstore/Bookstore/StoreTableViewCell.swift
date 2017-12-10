//
//  StoreTableViewCell.swift
//  Bookstore
//
//  Created by Erica Solum on 11/24/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import Alamofire

class StoreTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    var processorDelegate: BookProcessor?
    var book: Book?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Button Actions
    
    @IBAction func buyButtonClicked(_ sender: UIButton) {
        if let del = processorDelegate {
            //Call on its delegate to process book
            if let b = book {
                del.processBook(book: b)
            }
        }
    }
}
