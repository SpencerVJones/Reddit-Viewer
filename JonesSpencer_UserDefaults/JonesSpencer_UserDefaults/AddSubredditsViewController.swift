//  AddSubredditsViewController.swift
//  JonesSpencer_UserDefaults
//  Created by Spencer Jones on 4/21/24.

import UIKit

class AddSubredditsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    
    // Property to hold subreddits
    var subreddits = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegate to textField
        textField.delegate = self
        
        // Reload table view
        tableView.reloadData()
    }
    
    // Implement text field should return method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Will lower keyboard when return button tapped
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // 1 section
    }
    
    // Return number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subreddits.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "SubredditsCell", for: indexPath)
        
        // Configure cell
        cell.textLabel?.text = subreddits[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove item from subreddits
            subreddits.remove(at: indexPath.row)
            
            // Update table view to reflect change
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: Header Methods
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Return title for header in section
        return "Subreddits"
    }
    
    // Set header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // MARK: Storyboard Actions
    @IBAction func addButtonTapped(_ sender: UIButton) {
        // Add subreddit name from the text field to subreddits
        if let subreddit = textField.text, !subreddit.isEmpty {
            subreddits.append(subreddit)
            
            // Clear text field
            textField.text = ""
            
            // Reload table view
            tableView.reloadData()
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // set userDefaults
        UserDefaults.standard.set(subreddits, forKey: "subreddits")
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // Reset subreddits to original value
        subreddits = ["FloridaMan"]
        
        // set userDefaults
        UserDefaults.standard.set(subreddits, forKey: "subreddits")
        
        // Reload table view
        tableView.reloadData()
    }
}
