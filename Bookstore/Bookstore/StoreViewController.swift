//
//  StoreViewController.swift
//  Bookstore
//
//  Created by Erica Solum on 11/24/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import ImageLoader
import GoConnector

class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BookProcessor, StoreDelegate {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private var bookList = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleBooks()
        //Set delegates for table view
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        (UIApplication.shared.delegate as? AppDelegate)?.cloverConnectorListener?.viewController = self
    }
    
    
    // MARK: - Table View Delegate Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as! StoreTableViewCell
        cell.nameLabel.text = bookList[indexPath.row].title
        cell.authorName.text = bookList[indexPath.row].author
        cell.priceLabel.text = String(format: "$%.2f", bookList[indexPath.row].price)
        cell.book = bookList[indexPath.row]
        cell.processorDelegate = self
        if let url = URL(string: bookList[indexPath.row].coverImageURL) {
            cell.coverImage.load.request(with: url)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Store Delegate Functions
    func setListenersViewController() {
        (UIApplication.shared.delegate as? AppDelegate)?.cloverConnectorListener?.viewController = self
    }
    
    // MARK: - Helper Functions
    private func loadSampleBooks() {
        let book = Book(title: "Le Petit Prince", author: "Antoine de Saint-Exupéry", imgURL: "http://images.contentful.com/7h71s48744nc/2dZDnzFSyA0Gic0Ak6eCMO/8379dcad0e2b2bd59482cb356f619e8b/little-prince-cover.jpg", price: 5.50)
        
        let book2 = Book(title: "Harry Potter and the Philosopher's Stone", author: "J. K. Rowling", imgURL: "http://vignette3.wikia.nocookie.net/harrypotter/images/8/86/Sorcerer%27s_stone_cover.jpg/revision/latest?cb=20060726180434", price: 7.00)
        
        let book3 = Book(title: "The Hobbit", author: "J. R. R. Tolkein", imgURL: "https://cdn.pastemagazine.com/www/system/images/photo_albums/hobbit-book-covers/large/photo_5653_0-8.jpg?1384968217", price: 6.5)
        
        let book4 = Book(title: "And Then There Were None", author: "Agatha Christie", imgURL: "https://upload.wikimedia.org/wikipedia/en/2/26/And_Then_There_Were_None_US_First_Edition_Cover_1940.jpg", price: 5.5)
        
        let book5 = Book(title: "Alice in Wonderland", author: "Lewis Carroll", imgURL: "https://flavorwire.files.wordpress.com/2011/01/alice2.jpg", price: 6.0)
        
        self.bookList = [book, book2, book3, book4, book5]
    }
    
    func processBook(book: Book) {
        let totalInInt = Int(book.price * 100) //  amount should be in cents
        let saleReq = SaleRequest(amount:totalInInt, externalId:"\(arc4random())") // pass total amount in cents and random external Id
        if let cloverConnector = (UIApplication.shared.delegate as? AppDelegate)?.cloverConnector {
            saleReq.allowOfflinePayment = true
            saleReq.approveOfflinePaymentWithoutPrompt = true
            saleReq.autoAcceptSignature = true
            saleReq.autoAcceptPaymentConfirmations = true
            saleReq.disablePrinting = true
            saleReq.disableRestartTransactionOnFail = true
            saleReq.cardNotPresent = true
            saleReq.tipAmount = nil
            saleReq.tipMode = SaleRequest.TipMode.ON_SCREEN_BEFORE_PAYMENT
            
            saleReq.cardEntryMethods = cloverConnector.CARD_ENTRY_METHOD_MANUAL
            cloverConnector.sale(saleReq)
        }
    }
    func paymentVCDismissed() {
        (UIApplication.shared.delegate as? AppDelegate)?.cloverConnectorListener?.viewController = self
    }
}

protocol StoreDelegate {
    func paymentVCDismissed()
}
