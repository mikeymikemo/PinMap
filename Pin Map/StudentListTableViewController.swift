//
//  StudentListTableViewController.swift
//  Pin Map
//
//  Created by Michael Montoya on 2/9/17.
//  Copyright © 2017 Michael Montoya. All rights reserved.
//

import UIKit

class StudentListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Constants.Parse.studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as? StudentInfoTableViewCell else { return UITableViewCell() }
        
        let student = Student(dictionary: Constants.Parse.studentLocations[indexPath.row])
        
        cell.nameTextField.text = student.fullName
        
        
        return cell
    }



}
