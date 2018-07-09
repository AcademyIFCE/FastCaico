//
//  ActiveRecord.swift
//  FastCaico
//
//  Created by Yuri on 09/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import Foundation
protocol ActiveRecord {
    associatedtype Item: Decodable
    static func all() -> [Item]?
}

extension ActiveRecord {
    static var className: String {
        return String(describing: self)
    }
    
    static func all() -> [Item]?{
        guard
            let fileURL = Bundle.main.url(forResource: self.className, withExtension: ".json"),
            let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        return try? JSONDecoder().decode([Item].self, from: data)
    }
}
