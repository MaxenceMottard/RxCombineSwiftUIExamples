//
//  ClubsListWithRxViewModel.swift
//  ImplementSwiftUIInUIKitArchi
//
//  Created by Maxence Mottard on 05/04/2024.
//

import Foundation
import RxSwift

final class ClubsListWithRxViewModel {
    private let bag = DisposeBag()

    private let getClubsWorker = GetClubsRxWorker()

    let clubsSubject = BehaviorSubject<[Club]>(value: [])

    init() {}

    func fetchClubs() {
        getClubsWorker.fetchClubs()
            .subscribe(
                onNext: { [weak self] clubs in
                    self?.clubsSubject.onNext(clubs)
                }
            )
            .disposed(by: bag)
    }

    func addNewItem() {
        let newClub = Club(
            id: UUID().uuidString,
            isHidden: false,
            name: "New added club",
            address: "",
            email: "",
            phoneNumber: nil,
            coordinates: nil,
            description: "Club added from a function to test reactive app"
        )
        let currentClubs = try? clubsSubject.value()
        var newClubs = currentClubs ?? []
        newClubs.append(newClub)

        clubsSubject.onNext(newClubs)
    }
}
