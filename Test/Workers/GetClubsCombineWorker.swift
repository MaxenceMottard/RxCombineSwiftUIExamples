//
//  GetClubsCombineWorker.swift
//  ImplementSwiftUIInUIKitArchi
//
//  Created by Maxence Mottard on 05/04/2024.
//

import Combine

struct GetClubsCombineWorker {
    let service = GetClubsWebService()

    func fetchClubs() -> AnyPublisher<GetClubsWebServiceResponse, Error> {
        service.fetchClubs().asPublisher()
    }
}
