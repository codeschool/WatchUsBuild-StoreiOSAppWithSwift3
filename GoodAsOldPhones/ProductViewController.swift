//
//  ProductViewController.swift
//  GoodAsOldPhones
//
//  Created by Jon Friskics on 8/30/16.
//  Copyright © 2016 Code School. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!

    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = product {
            productNameLabel.text = p.name
            if let i = p.productImage {
                productImageView.image = UIImage(named: i)
            }
        }
    }

    @IBAction func addToCartPressed(_ sender: AnyObject) -> Void {
        print("Button tapped")
        
        guard let product = product, let price = product.price else {
            return
        }
        
        let alertController = UIAlertController(title: "Saved to Cart", message: "Saved to cart with a price of \(price)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        let order = Order()
        order.order_id = 1
        order.product = product
        
        var orders = Orders.readOrdersFromArchive()
        
        /* fix: Added 01/03/2017
                We forgot to add this logic during the recording of the Watch Us Build
                Check if the orders array exists.  If it doesn't, then create a new array with a single order in it.
                If the orders array does exist, then just append the new order to it.
        */
        if(orders == nil) {
            orders = [order]
        } else {
            orders?.append(order)
        }
        
        if let orders = orders {
            if(Orders.saveOrdersToArchive(orders: orders)) {
                present(alertController, animated: true, completion: nil)
            }
        }
    }
}
