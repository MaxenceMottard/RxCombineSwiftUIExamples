//
//  ClubsListWithRxSwiftUIView.swift
//  Test
//
//  Created by Maxence Mottard on 06/04/2024.
//

import SwiftUI

struct ClubsListWithRxSwiftUIView<ViewModel: ClubsListWithRxSwiftUIViewModelling>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: @escaping () -> ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        List {
            ForEach(viewModel.clubs) { club in
                ClubView(club: club)
            }
        }
        .listStyle(.plain)
        .onAppear { viewModel.fetchClubs() }
        .navigationTitle("Clubs")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add club", action: { viewModel.addNewItem() })
            }
        }
    }

    struct ClubView: View {
        let club: Club

        var body: some View {
            VStack(spacing: 8) {
                Text(club.name)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color(.primaryText))
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let description = club.description {
                    Text(description)
                        .font(.system(size: 12, weight: .light))
                        .foregroundStyle(Color(.secondaryText))
                        .lineLimit(6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

#Preview {
    class ClubsListWithRxSwiftUIViewModellingMock: ClubsListWithRxSwiftUIViewModelling {
        var clubs: [Club]
        init(clubs: [Club]) {
            self.clubs = clubs
        }
        func fetchClubs() {}
        func addNewItem() {}
    }

    let viewModel = ClubsListWithRxSwiftUIViewModellingMock(
        clubs: [
            .init(id: "123", isHidden: false, name: "First club", address: "", email: "", phoneNumber: nil, coordinates: nil, description: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"),
            .init(id: "1234", isHidden: false, name: "Secondary club", address: "", email: "", phoneNumber: nil, coordinates: nil, description: "Sed ut perspiciatis unde omnis"),
            .init(id: "12345", isHidden: false, name: "Club without description", address: "", email: "", phoneNumber: nil, coordinates: nil, description: nil)
        ]
    )

    return NavigationStack {
        ClubsListWithRxSwiftUIView {
            viewModel
        }
    }
}
