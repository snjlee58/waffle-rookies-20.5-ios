//
//  ViewController.swift
//  NewsApp
//
//  Created by 이선재 on 2022/09/24.
//

import UIKit

class NewsListViewController: UIViewController {
    let newsModel: NewsModel
    
    let tableView = UITableView()
    let searchBar = UISearchBar()
    
    init(newsModel: NewsModel) {
        self.newsModel = newsModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        applyDesign()
    }
    
    func fetchArticles(query: String) {
        self.newsModel.request(from: query, completionHandler: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

}

extension NewsListViewController {
    private func setupLayout() {
        // Configure searchBar
        self.navigationItem.titleView = self.searchBar
        let searchBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        self.navigationItem.rightBarButtonItem = searchBarButton
        
        searchBar.delegate = self
        
        // Configure tableView
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func applyDesign() {
        self.view.backgroundColor = .white
        
        // SearchBar
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.placeholder = "헤드라인을 검색해보세요"
    }
    
    @objc func didTapSearchButton() {
        self.fetchArticles(query: self.searchBar.searchTextField.text!)
    }
}

extension NewsListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query: String = self.searchBar.searchTextField.text!
        self.fetchArticles(query: query)
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        let news = self.newsModel.items[indexPath.row]
        cell.configure(item: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}





