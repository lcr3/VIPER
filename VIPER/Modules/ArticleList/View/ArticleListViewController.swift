//
//  ArticleListViewController.swift
//  VIPER
//
//  Created by ryookano on 2020/01/16.
//  Copyright © 2020 ryookano. All rights reserved.
//

import UIKit

protocol ArticleListView: AnyObject {

    func setLastSearchText(_ text: String)
    func showRefreshView()
    func updateArticles(_ Articles: [Article])
    func showErrorMessageView(reason: String)
}

class ArticleListViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    // Presenterへのアクセスはprotocolを介して行う
    var presenter: ArticleListViewPresentation!

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(ArticleCell.self)
            tableView.refreshControl = refreshControl
        }
    }
    @IBOutlet private weak var errorMessageLabel: UILabel!
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "検索キーワードを入力..."

        searchBar.delegate = self

        return searchBar
    }()
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged(sender:)), for: .valueChanged)
        return refreshControl
    }()

    private var articles: [Article] = [] {
        didSet {
            DispatchQueue.main.async {
                self.errorMessageLabel.isHidden = true
                self.tableView.reloadData() // 画面の更新

                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = searchBar

        presenter.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        guard let text = searchBar.text else { return }

        presenter.refreshControlValueChanged(searchText: text)
    }
}

// Viewのプロトコルに準拠する
extension ArticleListViewController: ArticleListView {

    func setLastSearchText(_ text: String) {
        searchBar.text = text
    }

    func showRefreshView() {
        guard !refreshControl.isRefreshing else { return }

        refreshControl.beginRefreshingManually(in: tableView)
    }

    func updateArticles(_ articles: [Article]) {
        self.articles = articles
    }

    func showErrorMessageView(reason: String) {
        DispatchQueue.main.async {
            self.errorMessageLabel.text = reason
            self.errorMessageLabel.isHidden = false
        }
    }
}

extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setArticle(articles[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

extension ArticleListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }

        presenter.searchButtonDidPush(searchText: text)

        searchBar.resignFirstResponder()
    }
}

extension UIRefreshControl {

    func beginRefreshingManually(in scrollView: UIScrollView) {
        beginRefreshing()
        let offset = CGPoint.init(x: 0, y: -frame.size.height)
        scrollView.setContentOffset(offset, animated: true)
    }
}
