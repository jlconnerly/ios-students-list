//
//  MainViewController.swift
//  Students
//
//  Created by Jake Connerly on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var sortSelector: UISegmentedControl!
    @IBOutlet weak var filterSelector: UISegmentedControl!
    
    private var studentsTableViewController: StudentsTableViewController! {
        didSet {
            updateDataSource()
        }
    }
    
    private var students: [Student] = [] {
        didSet { // didSet runs automatically when students changes
            updateDataSource()
        }
    }
    private let studentController = StudentController()

    override func viewDidLoad() {
        super.viewDidLoad()

        studentController.loadFromPersistantStore { students, error in  //this is the start of our closure.  Put in "envelope" to execute at a future time
            if let error = error {
                print("error loading students: \(error)")
                return
            }
            
            DispatchQueue.main.async { // this function is being called from a background thread so this code allows us to run on main thread
                self.students = students ?? [] //adding self lets this viewcontroller know we're trying to load to its students array
            }
        } // this is the end of the closeure to be used in our function
    }
    
    @IBAction func sort(_ sender: UISegmentedControl) {
        updateDataSource()
    }
    
    @IBAction func filter(_ sender: UISegmentedControl) {
        updateDataSource()
    }
    
    private func updateDataSource() {
        var sortedAndFilteredStudents: [Student]
        switch filterSelector.selectedSegmentIndex { //switching on the filter SegmentedControl
        case 1: // filter for iOS
            sortedAndFilteredStudents = students.filter { $0.course == "iOS" } //this is looping over students and making a copy array that has course "iOS"
        case 2: //filter for Web
            sortedAndFilteredStudents = students.filter { $0.course == "Web" }
        case 3: //filter on UX
            sortedAndFilteredStudents = students.filter { $0.course == "UX" }
        default: //filter for none or anyother number
            sortedAndFilteredStudents = students
        }
        
        if  sortSelector.selectedSegmentIndex == 0 { // sort based on first name
            sortedAndFilteredStudents = sortedAndFilteredStudents.sorted {
                $0.firstName < $1.firstName //checking ACII table to sort Alphabetically
            }
        }else { //sort based on last name
            sortedAndFilteredStudents = sortedAndFilteredStudents.sorted {
                $0.lastName < $1.lastName
            }
        }
        
        studentsTableViewController.students = sortedAndFilteredStudents
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        studentsTableViewController = (segue.destination as! StudentsTableViewController)
    }
    

}
