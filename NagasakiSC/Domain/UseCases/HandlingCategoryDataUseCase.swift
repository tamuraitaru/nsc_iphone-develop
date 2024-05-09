//
//  PersistenceViewModel.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/03.
//

import Foundation
import CoreData

class HandlingCategoryDataUseCase: ObservableObject {
    @Published var categoriesInfo: CategoriesInfo?

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchCategoriesInfo()
    }

    private func fetchCategoriesInfo() {
        let fetchRequest: NSFetchRequest<CategoriesInfo> = CategoriesInfo.fetchRequest()
        do {
            let fetchedCategoriesInfos = try context.fetch(fetchRequest)
            categoriesInfo = fetchedCategoriesInfos.first
        } catch {
            print("Error fetching categoriesInfo: \(error)")
        }
    }

    func createCategoriesData(categories: Set<String>) {
        if let categoriesInfo = categoriesInfo {
            do {
                let categoriesData = try NSKeyedArchiver.archivedData(withRootObject: categories, requiringSecureCoding: false) as Data
                categoriesInfo.categories = categoriesData
                try context.save()
                fetchCategoriesInfo() // 更新後に再度データを読み込む
            } catch {
                print("Error creating or updating categoriesInfo: \(error)")
            }
        } else {
            // カテゴリ情報が存在しない場合は新しいカテゴリ情報を作成する
            do {
                let newCategoriesInfo = CategoriesInfo(context: context)
                let categoriesData = try NSKeyedArchiver.archivedData(withRootObject: categories, requiringSecureCoding: false) as Data
                newCategoriesInfo.categories = categoriesData
                try context.save()
                fetchCategoriesInfo() // 更新後に再度データを読み込む
            } catch {
                print("Error creating categoriesInfo: \(error)")
            }
        }
    }

    func updateCategoriesData(categories: Set<String>) {
        if let categoriesInfo = categoriesInfo {
            do {
                let categoriesData = try NSKeyedArchiver.archivedData(withRootObject: categories, requiringSecureCoding: false) as Data
                categoriesInfo.categories = categoriesData
                try context.save()
                fetchCategoriesInfo() // 更新後に再度データを読み込む
            } catch {
                print("Error creating or updating categoriesInfo: \(error)")
            }
        } else {
            // カテゴリ情報が存在しない場合は新しいカテゴリ情報を作成する
            do {
                let newCategoriesInfo = CategoriesInfo(context: context)
                let categoriesData = try NSKeyedArchiver.archivedData(withRootObject: categories, requiringSecureCoding: false) as Data
                newCategoriesInfo.categories = categoriesData
                try context.save()
                fetchCategoriesInfo() // 更新後に再度データを読み込む
            } catch {
                print("Error creating categoriesInfo: \(error)")
            }
        }
    }

    func readCategoriesData() -> Set<String> {
        guard let categoriesInfo = categoriesInfo, let categories = categoriesInfo.categories else {
            print("readCategoriesData: categoriesInfo or categories is nil")
            return []
        }
        return categories.toStrings()
    }

    func deleteCategoriesData() {
        guard let categoriesInfo = categoriesInfo else {
            print("deleteCategoriesData: categoriesInfo is nil")
            return
        }
        context.delete(categoriesInfo)
        do {
            try context.save()
            self.categoriesInfo = nil
        } catch {
            print("Error deleting notificationsInfo: \(error)")
        }
    }
}
