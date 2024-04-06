//
//  GetClubsRxWorker.swift
//  ImplementSwiftUIInUIKitArchi
//
//  Created by Maxence Mottard on 05/04/2024.
//

import RxSwift

struct GetClubsRxWorker {
    let service = GetClubsWebService()

    func fetchClubs() -> Observable<GetClubsWebServiceResponse> {
        service.fetchClubs()
    }
}
