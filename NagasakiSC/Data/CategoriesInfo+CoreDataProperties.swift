//
//  CategoriesInfo+CoreDataProperties.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/03.
//
//

import Foundation
import CoreData

extension CategoriesInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoriesInfo> {
        return NSFetchRequest<CategoriesInfo>(entityName: "CategoriesInfo")
    }

    @NSManaged public var categories: Data?

}

extension CategoriesInfo: Identifiable {

}
