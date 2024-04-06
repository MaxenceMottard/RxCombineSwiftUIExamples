//
//  GetClubsWebServiceResponse.swift
//  ImplementSwiftUIInUIKitArchi
//
//  Created by Maxence Mottard on 05/04/2024.
//

import Foundation

typealias GetClubsWebServiceResponse = [Club]

struct Club: Codable, Identifiable {
    let id: String
    let isHidden: Bool
    let name: String
    let address: String?
    let email: String
    let phoneNumber: String?
    let coordinates: Coordinates?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case isHidden
        case name
        case address
        case email
        case phoneNumber
        case coordinates
        case description
    }

    struct Coordinates: Codable {
        let latitude: String
        let longitude: String
    }
}
