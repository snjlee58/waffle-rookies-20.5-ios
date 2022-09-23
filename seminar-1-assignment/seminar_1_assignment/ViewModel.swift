//
//  ViewModel.swift
//  seminar1
//
//  Created by 한상현 on 2022/09/13.
//

// ReactorKit
// Rips
// MVVM

class TaskCellViewModel: Codable {
    var task: String?
    var isDone: Bool?
    
    init(task: String, isDone: Bool) {
        self.task = task
        self.isDone = isDone
    }
    
    func setIsDone(isDone: Bool) {
        self.isDone = isDone
    }
}

class ViewModel {
    var pairDataSource: [TaskCellViewModel] = [
//        TaskCellViewModel(task: "A", isDone: true),
//        TaskCellViewModel(task: "B", isDone: true),
//        TaskCellViewModel(task: "C", isDone: false),
//        TaskCellViewModel(task: "D", isDone: false),
//        TaskCellViewModel(task: "E", isDone: true)
    ] 
}
