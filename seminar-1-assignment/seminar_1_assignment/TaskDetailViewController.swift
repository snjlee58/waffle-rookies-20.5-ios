//
//  TaskDetailViewController.swift
//  seminar_1_assignment
//
//  Created by 이선재 on 2022/09/23.
//

import UIKit

protocol DeleteTaskDelegate: AnyObject {
    func deleteTaskData(taskToDelete: TaskCellViewModel) // 삭제할 task 객체를 전달함
    func editTaskData(taskToEdit: TaskCellViewModel, newTaskText: String) // 수정할 task 객체를 전달함
}

class TaskDetailViewController: UIViewController {
    
    var delegate: DeleteTaskDelegate?
    var taskCellModel: TaskCellViewModel?
    let taskTextField = UITextField()
    let saveTaskButton = UIButton()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        
        // titleLabel
        let titleLabel = UILabel()
        titleLabel.text = "할 일 수정:"
        titleLabel.font = .systemFont(ofSize: 17)
        
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25)
        ])
        
        // taskTextField
        taskTextField.borderStyle = .line
        taskTextField.text = self.taskCellModel?.task
        taskTextField.clearButtonMode = .whileEditing
        taskTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        self.view.addSubview(taskTextField)
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          taskTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
          taskTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
          taskTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
          taskTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
        ])
        
        // saveTaskButton
        self.saveTaskButton.setTitle("저장", for: .normal)
        self.saveTaskButton.backgroundColor = .red
        self.saveTaskButton.layer.cornerRadius = 5
        self.saveTaskButton.addTarget(self, action: #selector(tapSaveTaskButton), for: .touchUpInside)
        
        self.view.addSubview(self.saveTaskButton)
        self.saveTaskButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.saveTaskButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 50),
            self.saveTaskButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            self.saveTaskButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -300)
        ])
    
        // deleteTaskButton
        let deleteTaskButton = UIButton()
        deleteTaskButton.setTitle("삭제", for: .normal)
        deleteTaskButton.backgroundColor = .gray
        deleteTaskButton.layer.cornerRadius = 5
        deleteTaskButton.addTarget(self, action: #selector(tapDeleteTaskButton), for: .touchUpInside)
        
        self.view.addSubview(deleteTaskButton)
        deleteTaskButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteTaskButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 50),
            deleteTaskButton.leadingAnchor.constraint(equalTo: self.saveTaskButton.trailingAnchor, constant: 20),
            deleteTaskButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -300)
        ])
        
    }
    
    @objc private func textFieldDidChange() {
        self.validateInputField()
    }

    private func validateInputField() {
        if self.taskTextField.text!.isEmpty || self.taskTextField.text!.count > 20 {
            self.saveTaskButton.isEnabled = false
        } else {
            self.saveTaskButton.isEnabled = true
        }

    }
    
    @objc func tapSaveTaskButton() {
        self.delegate?.editTaskData(taskToEdit: self.taskCellModel!, newTaskText: self.taskTextField.text!)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapDeleteTaskButton() {
        self.delegate?.deleteTaskData(taskToDelete: self.taskCellModel!)
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
