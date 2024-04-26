//  ViewController.swift
//  JonesSpencer_UserDefaults
//  Created by Spencer Jones on 4/21/24.

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet var TableView: UITableView!
    @IBOutlet var colorView: UIView!
    
    var posts = [Post]() // Empty array of Posts
    var subreddits = ["FloridaMan"]  // Default subreddit
    var filteredPostsBySubreddit = [String: [Post]]() //  Dictionary to store filtered posts by subreddit
    
    // Default theme colors
    var titleColor = UIColor.black
    var authorColor = UIColor(displayP3Red: 255/255, green: 68/255, blue: 0/255, alpha: 1)
    var viewColor = UIColor.white
    var cellsColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load title color from UserDefauls
        if let savedColor = UserDefaults.standard.color(forKey: "titleColor") {
            titleColor = savedColor
        }
        
        // Load author color from UserDefaults
        if let savedColor = UserDefaults.standard.color(forKey: "authorColor") {
            authorColor = savedColor
        }
        
        // Load background color from UserDefaults
        if let savedColor = UserDefaults.standard.color(forKey: "viewColor") {
            viewColor = savedColor
        }
        
        // Load cells color from UserDefaults
        if let savedColor = UserDefaults.standard.color(forKey: "cellsColor") {
            cellsColor = savedColor
        }
        
        // Load subreddits from UserDefaults
        if let savedSubreddits = UserDefaults.standard.array(forKey: "subreddits") as? [String] {
            subreddits = savedSubreddits
            
        }
        
        // Parse subreddits
        for subreddit in subreddits {
            let url = "https://www.reddit.com/r/\(subreddit)/.json"
            downloadAndParse(jsonAtUrl: url)
        }
        
        // Populate filteredPostsBySubreddit dictionary
        for subreddit in subreddits {
            self.filteredPostsBySubreddit[subreddit] = self.posts.filter { $0.subreddit == subreddit }
        }
    }
    
    //  Method to populate posts and filter by subreddit
    func updatePostsAndFilterBySubreddit() {
        // Clearing existing posts
        posts.removeAll()
        
        // Parse subreddits
        for subreddit in subreddits {
            let url = "https://www.reddit.com/r/\(subreddit)/.json"
            downloadAndParse(jsonAtUrl: url)
        }
        
        // Filter posts by subreddit
        for subreddit in subreddits {
            filteredPostsBySubreddit[subreddit] = posts.filter { $0.subreddit == subreddit }
        }
        
        // Reload the table view
        TableView.reloadData()
    }
    
    // MARK: UITableViewDataSource Protocol Callbacks
    func numberOfSections(in tableView: UITableView) -> Int {
        return subreddits.count // Number of subreddits
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the amount of rows for the amount of posts in posts array
        let subreddit = subreddits[section]
        return filteredPostsBySubreddit[subreddit]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell_ID_1", for: indexPath) as? RedditTableViewCell
        else { return tableView.dequeueReusableCell(withIdentifier: "cell_ID_1", for: indexPath)}
        
        // Configure cell
        let subreddit = subreddits[indexPath.section]
        if let posts = filteredPostsBySubreddit[subreddit] {
            let post = posts[indexPath.row]
            cell.title.text = post.title
            cell.title.textColor = titleColor
            cell.user.text = post.formattedAuthor
            cell.user.textColor = authorColor
            cell.tableImage.image = post.thumbnail
            colorView.backgroundColor = viewColor
        }
        // Return configured cell
        return cell
    }
    
    // Set height of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    // MARK: Header Methods
    func tableView(_ TableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return subreddits[section] // Title for each section
    }
    
    func tableView(_ TableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50 // Set header height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = cellsColor // cell background color
    }
    
    
    // MARK: Navagation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? AddSubredditsViewController {
            secondVC.subreddits = self.subreddits
        }
        if let secondVC = segue.destination as? ThemeViewController {
            secondVC.titleColor = self.titleColor
            secondVC.authorColor = self.authorColor
            secondVC.viewColor = self.viewColor
            secondVC.cellsColor = self.cellsColor
        }
    }
    
    @IBAction func unwindToFirstViewController(segue: UIStoryboardSegue) {
        // Unwind from AddSubredditsViewController
        if let sourceVC = segue.source as? AddSubredditsViewController {
            // Update subreddits array
            subreddits = sourceVC.subreddits
            
            // Call update posts and filter by subreddit method
            updatePostsAndFilterBySubreddit()
        }
        
        // Unwind from ThemeViewController
        if let sourceVC = segue.source as? ThemeViewController {
            self.titleColor = sourceVC.titleColor!
            self.authorColor = sourceVC.authorColor!
            self.viewColor = sourceVC.viewColor!
            self.cellsColor = sourceVC.cellsColor!
            
            // Reload the table view
            TableView.reloadData()
        }
    }
}
