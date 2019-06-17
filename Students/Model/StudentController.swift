//
//  StudentController.swift
//  Students
//
//  Created by Jake Connerly on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation

class StudentController {
    
    private var persistantFileURL: URL? {
        guard let filePath = Bundle.main.path(forResource: "students", ofType: "json") else { return nil }
        return URL(fileURLWithPath: filePath)
    }
    
    func loadFromPersistantStore (completion: @escaping ([Student]?, Error?) -> Void) { // code after completion is declairing our closure
        let bgQueue = DispatchQueue(label: "studentQueue", attributes: .concurrent)
        
        bgQueue.async {
            let fm = FileManager.default
            guard let url = self.persistantFileURL,
                  fm.fileExists(atPath: url.path) else { return } // this just returns true or false checking if file actually exsists
            
            do {
                let data = try Data(contentsOf: url) //have to "try" because typeof Data can throw an error.
                let decoder = JSONDecoder()
                let students = try decoder.decode([Student].self, from: data) //decode JSON file and create an array of Student from our data(student.json)
                completion(students, nil) //if code runs to this line. We have properly decoded the JSON file. Pass in and load students array and error == nil.
                                          //if any of the previous lines fail, the do will "jump" to catch block
            } catch {            // if anything after "try" "throws" an error, we will "catch" the error and do something instead of crashing
                print("error loading student data: \(error)")
                completion(nil, error) // if an error occurred then completion has students == nil and error is our error
            }
        } // this is the end of our backgroundQueue so it does not interrput the stuff happening in our main thread because it could take awhile
    }
}
