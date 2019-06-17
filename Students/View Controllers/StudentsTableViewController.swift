//
//  StudentsTableViewController.swift
//  Students
//
//  Created by Jake Connerly on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController {
    
    var students: [Student] = [] {
        didSet {
            tableView.reloadData()
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)

        let aStudent = students[indexPath.row]
        cell.textLabel?.text = aStudent.name
        cell.detailTextLabel?.text = aStudent.course

        return cell
    }
}
