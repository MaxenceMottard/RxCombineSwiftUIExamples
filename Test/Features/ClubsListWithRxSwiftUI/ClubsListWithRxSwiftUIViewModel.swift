//
//  ClubsListWithRxSwiftUIViewModel.swift
//  ImplementSwiftUIInUIKitArchi
//
//  Created by Maxence Mottard on 05/04/2024.
//

import Foundation
import RxSwift

protocol ClubsListWithRxSwiftUIViewModelling: ObservableObject {
    var clubs: [Club] { get }

    func fetchClubs()
    func addNewItem()
}

final class ClubsListWithRxSwiftUIViewModel: ClubsListWithRxSwiftUIViewModelling {
    private let bag = DisposeBag()

    private let getClubsWorker = GetClubsRxWorker()

    @Published var clubs: [Club] = []

    init() {}

    func fetchClubs() {
        getClubsWorker.fetchClubs()
            .subscribe(
                onNext: { clubs in
                    DispatchQueue.main.async { [weak self] in
                        self?.clubs = clubs
                    }
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


        clubs.append(newClub)
    }
}
