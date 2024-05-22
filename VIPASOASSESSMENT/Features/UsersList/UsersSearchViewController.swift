//
//  UsersListViewController.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import MessageUI
import RxCocoa
import RxSwift
import UIKit

class UsersSearchViewController: PlainTableViewController {

    // MARK: - Interface

    enum OutAction {
        case sendEmail(UserInfo)
    }

    private let sendOutAction: (OutAction) -> Void

    // MARK: - Init

    private let viewModel: UsersSearchViewModel

    init(viewModel: UsersSearchViewModel, tableViewStyle: UITableView.Style = .plain, sendOutAction: @escaping (OutAction) -> Void) {
        self.viewModel = viewModel
        self.sendOutAction = sendOutAction
        super.init(tableViewStyle: tableViewStyle)
    }

    public required convenience init() {
        fatalError("init() has not been implemented")
    }

    // MARK: - Views

    private lazy var searchBar = UISearchController(searchResultsController: nil)
    private let disposalBag = DisposeBag()

    // MARK: - View cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBinding()
    }

    // MARK: - Setup

    override func setupUI() {
        super.setupUI()
        setupNavigationController()
        setupSearchController()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = true
        title = Strings.usersSearchScreenTitle
        navigationItem.backBarButtonItem?.tintColor = Colors.appSignatureColor.color
    }

    private func setupSearchController() {
        navigationItem.searchController = searchBar
        searchBar.searchBar.placeholder = Strings.usersSearchPlaceHolder
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableView.register(TitledCell.self, forCellReuseIdentifier: String(describing: TitledCell.self))
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 96
    }

    func setupBinding() {
        // TableView dataSource
        viewModel.fetchedUsersList
            .observe(on: MainScheduler.asyncInstance)
            .do(onNext: { [weak self] _ in
                guard let self else { return }
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            })
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: TitledCell.self), cellType: TitledCell.self)) { _, viewModel, cell in
                cell.configure(with: viewModel)
            }
            .disposed(by: disposalBag)
        
        // selectedCell
        tableView.rx
            .modelSelected(UserInfo.self)
            .subscribe(onNext: { [unowned self] viewModel in
                sendOutAction(.sendEmail(viewModel))
                if let selectedCell = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedCell, animated: true)
                }
            }).disposed(by: disposalBag)
        
        // pull to refreash
        refreshControl.rx.controlEvent(.valueChanged).subscribe(onNext: {
            self.viewModel.loadData()
        }).disposed(by: disposalBag)
        
        
        // Indicator handler
        viewModel.viewState
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] result in
                switch result {
                    case .next(let state):
                        switch state {
                            case .loading, .error:
                                self?.tableView.isHidden = true
                            case .loaded(let array) where array.isEmpty:
                                self?.tableView.isHidden = true
                            default:
                                self?.tableView.isHidden = false
                        }
                        self?.handleStateChange(state: state)
                    default:
                        break
                }
            }
            .disposed(by: disposalBag)
        
        searchBar.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .map { $0.isEmpty ? Strings.usersSearchIntialValue : $0 }
            .bind(to: viewModel.searchTerm)
            .disposed(by: disposalBag)
    }
}
