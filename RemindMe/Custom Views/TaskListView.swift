//
//  TaskListView.swift
//  RemindMe
//
//  Created by Ishwar Silwal on 9/19/19.
//  Copyright © 2019 Ishwar Silwal. All rights reserved.
//

import UIKit

class TaskListView: ListView {
    
    private var dataArray = [Tasks]()
    var addTask:(()->Void)?

    override func awakeFromNib() {
        let identifiers = [CellIdentifier.EmptyTaskCell]
        for identifier in identifiers {
            tableView.registerIdentifier(identifier)
        }
        
        super .awakeFromNib()
    }
    
    func showTaskList(list:[Tasks]) {
        dataArray = list
        tableView.reloadData()
    }
}

extension TaskListView: UITableViewDelegate, UITableViewDataSource {
    private func isListEmpty() -> Bool {
        var isEmpty = false
        if dataArray.count == 0 {
            isEmpty = true
        }
        
        return isEmpty
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isListEmpty() {
            return 1
        }
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isListEmpty() {
            
        }
        
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.EmptyTaskCell, for: indexPath)
        return emptyCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is EmptyTaskCell {
            let emptyCell = cell as! EmptyTaskCell
            emptyCell.didTapAdd = {
                if let handler = self.addTask {
                    handler()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is EmptyTaskCell {
            let emptyCell = cell as! EmptyTaskCell
            emptyCell.didTapAdd = nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isListEmpty() {
            return UIScreen.main.bounds.size.height - barHeight();
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
