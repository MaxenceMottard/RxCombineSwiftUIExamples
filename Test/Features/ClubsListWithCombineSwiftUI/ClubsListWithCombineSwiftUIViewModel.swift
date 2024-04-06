//
//  ClubsListWithCombineSwiftUIViewModel.swift
//  ImplementSwiftUIInUIKitArchi
//
//  Created by Maxence Mottard on 05/04/2024.
//

import Foundation
import Combine

protocol ClubsListWithCombineSwiftUIViewModelling: ObservableObject {
    var clubs: [Club] { get }

    func fetchClubs()
    func addNewItem()
}

final class ClubsListWithCombineSwiftUIViewModel: ClubsListWithCombineSwiftUIViewModelling {
    private var getClubsTask: AnyCancellable?

    private let getClubsWorker = GetClubsCombineWorker()

    @Published var clubs: [Club] = []

    init() {}

    func fetchClubs() {
        getClubsTask = getClubsWorker.fetchClubs()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .sink { [weak self] clubs in
                self?.clubs = clubs
            }
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
