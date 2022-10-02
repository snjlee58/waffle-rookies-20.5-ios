//
//  AddTaskViewController.swift
//  seminar_1_assignment
//
//  Created by 이선재 on 2022/09/19.
//

import UIKit

protocol AddTaskViewDelegate: AnyObject {
    func sendData(newTask: TaskCellViewModel) // 할 일이 작성된 task 객체를 전달함
}

class AddTaskViewController: UIViewController {
    var delegate: AddTaskViewDelegate?
    
    let newTaskTextField = UITextField()
    let addTaskButton = UIButton()

    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        self.title = "할 일 추가"
        
        // newTaskTextField
        newTaskTextField.borderStyle = .line
        newTaskTextField.placeholder = "1자 이상 20자 이하"
        newTaskTextField.clearButtonMode = .whileEditing
        newTaskTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        self.view.addSubview(newTaskTextField)
        newTaskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          newTaskTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
          newTaskTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
          newTaskTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
          newTaskTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
        ])
        
        // addTaskButton
        addTaskButton.setTitle("추가", for: .normal)
        addTaskButton.backgroundColor = .darkGray
        addTaskButton.layer.cornerRadius = 5
        addTaskButton.isEnabled = false
        addTaskButton.addTarget(self, action: #selector(tapAddTaskButton), for: .touchUpInside)
        
        self.view.addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        addTaskButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        addTaskButton.topAnchor.constraint(equalTo: newTaskTextField.bottomAnchor, constant: 50),
        addTaskButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -250)
        ])
        
    }
    
    @objc private func textFieldDidChange() {
        self.validateInputField()
    }

    private func validateInputField() {
        if self.newTaskTextField.text!.isEmpty || self.newTaskTextField.text!.count > 20 {
            self.addTaskButton.isEnabled = false
        } else {
            self.addTaskButton.isEnabled = true
        }

    }

    @objc func tapAddTaskButton() {
        // Append new task object to viewModel
        let newTask = TaskCellViewModel(task: newTaskTextField.text!, isDone: false)
        self.delegate?.sendData(newTask: newTask)
        
        // Return to previous screen
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
