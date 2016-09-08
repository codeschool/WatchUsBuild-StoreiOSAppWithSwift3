//
//  Orders.swift
//  GoodAsOldPhones
//
//  Created by Jon Friskics on 9/8/16.
//  Copyright © 2016 Code School. All rights reserved.
//

import Foundation

class Orders: NSObject, NSCoding {
    var orders: [Order]?
    
    required init?(coder aDecoder: NSCoder) {
        self.orders = aDecoder.decodeObject(forKey: "orders") as! [Order]?
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.orders, forKey: "orders")
    }
    
    class func archiveFilePath() -> String {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent("cart.archive").path
    }
    
    class func readOrdersFromArchive() -> [Order]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: archiveFilePath()) as? [Order]
    }
    
    class func saveOrdersToArchive(orders: [Order]) -> Bool {
        return NSKeyedArchiver.archiveRootObject(orders, toFile: archiveFilePath())
    }
}
