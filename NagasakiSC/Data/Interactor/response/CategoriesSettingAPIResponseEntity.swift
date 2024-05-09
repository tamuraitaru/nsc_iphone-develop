//
//  CategoriesSettingAPIResponseEntity.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/03.
//

import Foundation

struct CategoriesSettingAPIResponseEntity: Codable {
    var categoriesSetting: [CategoriesSetting]
}

struct CategoriesSetting: Codable {
    var id: Int?
    var order: Int?
    var name: String?
}
