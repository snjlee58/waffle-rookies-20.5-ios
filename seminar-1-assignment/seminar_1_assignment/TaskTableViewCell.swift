//
//  TaskTableViewCell.swift
//  seminar_1_assignment
//
//  Created by 이선재 on 2022/09/19.
//

import UIKit
//
protocol TaskTableViewCellDelegate: AnyObject {
    func toggleTaskDoneData(cvm: TaskCellViewModel)
}

class TaskTableViewCell: UITableViewCell {
    var delegate: TaskTableViewCellDelegate?
    
    override var reuseIdentifier: String? {
        return "TableViewCell"
    }
    
    private let wordLabel = UILabel()
    private let doneButton = UIButton()
    private let editButton = UIButton()
    private var cellModel = TaskCellViewModel(task: "", isDone: false)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "TableViewCell")
//        self.contentView.backgroundColor = .lightGray
        
        // Task Label
        self.wordLabel.textColor = .black
        self.contentView.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wordLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            wordLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 50)
        ])
        
        // Done Button
        self.doneButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        self.contentView.addSubview(doneButton)
        self.doneButton.addTarget(self, action: #selector(tapTaskDoneButton), for: .touchUpInside)
        self.doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            doneButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
        ])
        
        // Edit Button
        let editButtonLabel = UILabel()
        editButtonLabel.text = ">"
        editButtonLabel.font = .systemFont(ofSize: 17)
        self.contentView.addSubview(editButtonLabel)
        editButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButtonLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            editButtonLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
        
    }
    
    func configure(cvm: TaskCellViewModel) {
        self.wordLabel.text = cvm.task
        self.cellModel = cvm
        
        if cvm.isDone == true {
            self.doneButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            self.doneButton.tintColor = .red
            self.wordLabel.textColor = .red
        } else {
            self.doneButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            self.doneButton.tintColor = .black
            self.wordLabel.textColor = .black
        }
    }
//
    @objc func tapTaskDoneButton() {
        self.delegate?.toggleTaskDoneData(cvm: self.cellModel)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
