//
//  BooksViewController.swift
//  Bookstore
//
//  Created by Erica Solum on 11/24/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import ImageLoader

class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Properties
    private var bookList = [Book]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleBooks()
        
        //Set delegates for table view
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Config.accessToken == "" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "connectVC") as! ConnectViewController
            // Assign app delegate's AuthDelegate to the view controller
            print("Assigning auth delegate to self")
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.authDelegate = vc
            
            present(vc, animated: true, completion: nil)
        }
    }

    // MARK: - Table View Delegate Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Booklist.count is \(bookList.count)")
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libCell", for: indexPath) as! LibraryTableViewCell
        cell.nameLabel.text = bookList[indexPath.row].title
        cell.authorName.text = bookList[indexPath.row].author
        if let url = URL(string: bookList[indexPath.row].coverImageURL) {
            cell.coverImage.load.request(with: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Helper Functions
    private func loadSampleBooks() {
        let book = Book(title: "Don Quixote", author: "Miguel de Cervantes", imgURL: "https://images-na.ssl-images-amazon.com/images/I/41d-rugLMRL._SX331_BO1,204,203,200_.jpg", price: 5.0)
        
        let book2 = Book(title: "A Tale of Two Cities", author: "Charles Dickens", imgURL: "https://images.penguinrandomhouse.com/cover/9780451530578", price: 7.50)
        
        let book3 = Book(title: "The Lord of the Rings", author: "J. R. R. Tolkein", imgURL: "https://images-na.ssl-images-amazon.com/images/I/91rq1j7GYhL.jpg", price: 8.0)
        
        self.bookList = [book, book2, book3]
    }
}
