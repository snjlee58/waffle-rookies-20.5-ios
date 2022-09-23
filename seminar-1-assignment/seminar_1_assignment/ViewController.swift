//
//  ViewController.swift
//  seminar1
//
//  Created by 한상현 on 2022/09/13.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel: ViewModel
    private let tableView = UITableView()
    
    init(viewModel: ViewModel) {
//        UserDefaults.standard.removeObject(forKey: "tasks")
        self.viewModel = viewModel
        if let data = UserDefaults.standard.value(forKey:"tasks") as? Data {
            let genres = try? PropertyListDecoder().decode([TaskCellViewModel].self, from: data)
            self.viewModel.pairDataSource = genres!
        }
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
}

extension ViewController {
    private func setupLayout() {
        // Configure navigation bar right button (add)
        self.title = "할 일"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddButton))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
       
        // Configure tableView
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        // Delegate, datasource
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func applyDesign() {
        self.view.backgroundColor = .white
//        tableView.backgroundColor = .darkGray
    }
    
    @objc func tapAddButton() {
        let nextVC = AddTaskViewController()
        nextVC.delegate = self
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pairDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        cell.configure(cvm: viewModel.pairDataSource[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("tapped cell at \(indexPath)")
        let taskDetailVC = TaskDetailViewController()
        taskDetailVC.taskCellModel = viewModel.pairDataSource[indexPath.row]
        taskDetailVC.delegate = self
        navigationController?.pushViewController(taskDetailVC, animated: true)
    }
}

extension ViewController: AddTaskViewDelegate {
    func sendData(newTask: TaskCellViewModel) {
        self.viewModel.pairDataSource.append(newTask)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.viewModel.pairDataSource), forKey:"tasks")
        self.tableView.reloadData()
    }
}

extension ViewController: TaskTableViewCellDelegate {
    func toggleTaskDoneData(cvm: TaskCellViewModel) {
        if cvm.isDone == true {
            cvm.isDone = false
        } else {
            cvm.isDone = true
        }
        self.tableView.reloadData()
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.viewModel.pairDataSource), forKey:"tasks")
    }
    
}

extension ViewController: DeleteTaskDelegate {
    func deleteTaskData(taskToDelete: TaskCellViewModel) {
        if let idx = self.viewModel.pairDataSource.firstIndex(where: { $0 === taskToDelete}) {
            self.viewModel.pairDataSource.remove(at: idx)
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.viewModel.pairDataSource), forKey:"tasks")
        self.tableView.reloadData()
    }
    
    func editTaskData(taskToEdit: TaskCellViewModel, newTaskText: String) {
        taskToEdit.task = newTaskText
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.viewModel.pairDataSource), forKey:"tasks")
        self.tableView.reloadData()
    }
}
