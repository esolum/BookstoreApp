//
//  Book.swift
//  Bookstore
//
//  Created by Erica Solum on 11/24/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import Foundation

class Book {
    var title: String!
    var author: String!
    var coverImageURL: String!
    var price: Double!
    
    init(title: String, author: String, imgURL: String, price: Double) {
        self.title = title
        self.author = author
        self.coverImageURL = imgURL
        self.price = price
    }
}

protocol BookProcessor {
    func processBook(book: Book)
}
