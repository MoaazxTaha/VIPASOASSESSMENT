//
//  PlainTableViewController.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import UIKit

open class PlainTableViewController: StatefulViewController {
    // MARK: - Views

    open var tableView: UITableView
    lazy var refreshControl = UIRefreshControl()

    // MARK: - Init

    public required convenience init() {
        self.init(tableViewStyle: .plain)
    }

    public init(tableViewStyle: UITableView.Style = .plain) {
        tableView = UITableView(frame: .zero, style: tableViewStyle)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupStatefulView()
    }
    
    // MARK: - setup

    open func setupUI() {
       
        setupTableView()

        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }

    open func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderTopPadding = 0
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = .systemBackground
    }

    open func setupConstraints() {
        tableView.withConstraints {
            [
                $0.alignTop(view.safeAreaLayoutGuide),
                $0.alignBottom(view.safeAreaLayoutGuide),
                $0.alignTrailing(view.safeAreaLayoutGuide),
                $0.alignLeading(view.safeAreaLayoutGuide)
            ]
        }

    }
}
