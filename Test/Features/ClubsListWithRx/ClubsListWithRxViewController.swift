//
//  ClubsListWithRxViewController.swift
//  ImplementSwiftUIInUIKitArchi
//
//  Created by Maxence Mottard on 05/04/2024.
//

import UIKit
import RxSwift

class ClubsListWithRxViewController: UITableViewController {
    private let bag = DisposeBag()

    private let viewModel: ClubsListWithRxViewModel

    init(viewModel: ClubsListWithRxViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
        viewModel.fetchClubs()
    }

    private func bindViewModel() {
        viewModel.clubsSubject
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: bag)
    }

    private func setupUI() {
        tableView.register(ClubsListCell.self, forCellReuseIdentifier: ClubsListCell.identifier)

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Clubs"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add club",
            style: .plain,
            target: self,
            action: #selector(barButtonTapped)
        )
    }

    @objc func barButtonTapped() {
        viewModel.addNewItem()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let clubs = try? viewModel.clubsSubject.value()
        
        return clubs?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClubsListCell.identifier, for: indexPath) as! ClubsListCell
        let club = try? viewModel.clubsSubject.value()[indexPath.row]
        cell.setup(with: club)

        return cell
    }
}
