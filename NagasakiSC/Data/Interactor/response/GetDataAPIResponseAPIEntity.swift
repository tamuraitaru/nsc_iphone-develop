//
//  GetDataAPIResponseAPI.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/17.
//

import Foundation

struct GetDataAPIResponseAPIEntity: Codable {
        let userId: String?
        let stadiumNo: String?
        let surname: String?
        let givenName: String?
        let kanaSurname: String?
        let kanaGivenName: String?
        let birthday: Int?
        let gender: String?
        let postalCode: String?
        let country: String?
        let state: String?
        let city: String?
        let street1: String?
        let street2: String?
        let phoneNumber: String?
        let faxNumber: String?
        let email: String?
        let deleteFlag: Int?
        let registeredDate: String?
        let updateDate: String?
        let countryNumber: String?
        let domesticPhoneNumber: String?
        let carLand: String?
        let carType: String?
        let carPurpose: String?
        let carNumber: String?
        let allowMail: String?

        enum CodingKeys: String, CodingKey {
            case userId = "USER_ID"
            case stadiumNo = "STADIUM_NO"
            case surname = "SURNAME"
            case givenName = "GIVENNAME"
            case kanaSurname = "KANA_SURNAME"
            case kanaGivenName = "KANA_GIVENNAME"
            case birthday = "BIRTHDAY"
            case gender = "GENDER"
            case postalCode = "POSTALCODE"
            case country = "COUNTRY"
            case state = "STATE"
            case city = "CITY"
            case street1 = "STREET1"
            case street2 = "STREET2"
            case phoneNumber = "PHONE_NUMBER"
            case faxNumber = "FAX_NUMBER"
            case email = "EMAIL"
            case deleteFlag = "DELETE_FLAG"
            case registeredDate = "REGISTERED_DATE"
            case updateDate = "UPDATE_DATE"
            case countryNumber = "COUNTRY_NUMBER"
            case domesticPhoneNumber = "DOM_PHONE_NUMBER"
            case carLand = "CAR_LAND"
            case carType = "CAR_TYPE"
            case carPurpose = "CAR_PURPOSE"
            case carNumber = "CAR_NUMBER"
            case allowMail = "ALLOW_MAIL"
        }
}
