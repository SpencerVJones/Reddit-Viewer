//  ThemeViewController.swift
//  JonesSpencer_UserDefaults
//  Created by Spencer Jones on 4/21/24.

import UIKit

class ThemeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var editingLabel: UILabel!
    
    // Slider Outlets
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    
    // Variables to keep track of colors
    var selectedTextColor: UIColor?
    var titleColor : UIColor?
    var authorColor : UIColor?
    var viewColor : UIColor?
    var cellsColor : UIColor?
    
    // Variable to keep track of selected cell index path
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set sliders starting values to match default text color
        for slider in [redSlider, greenSlider, blueSlider] {
            slider?.value = 0 // black
        }
    }
    
    // Helper method to update sliders based on given color
    func updateSliders(for color: UIColor) {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // 1 Section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // Four different cell titles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
        // Configure the cell based on the row
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Title Color"
            cell.textLabel?.textColor = titleColor
        case 1:
            cell.textLabel?.text = "Author Color"
            cell.textLabel?.textColor = authorColor
        case 2:
            cell.textLabel?.text = "Background Color"
            cell.textLabel?.textColor = viewColor
        case 3:
            cell.textLabel?.text = "Cell Colors"
            cell.textLabel?.textColor = cellsColor
        default: break
        }
        
        // Highlight selected cell
        if indexPath == selectedIndexPath {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Update selected index path
        selectedIndexPath = indexPath
        
        // Reload table view
        tableView.reloadData()
        
        // Update sliders based on selected text color and editing label
        switch indexPath.row {
        case 0:
            updateSliders(for: titleColor!)
            editingLabel.text = "Title color is being edited"
        case 1:
            updateSliders(for: authorColor!)
            editingLabel.text = "Author color is being edited"
        case 2:
            updateSliders(for: viewColor!)
            editingLabel.text = "Background color is being edited"
        case 3:
            updateSliders(for: cellsColor!)
            editingLabel.text = "Cell colors are being edited"
        default: break
        }
        
        // Update sliders values based on selected text color
        if let selectedTextColor = selectedTextColor {
            var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
            selectedTextColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            redSlider.value = Float(red)
            greenSlider.value = Float(green)
            blueSlider.value = Float(blue)
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        // Update the selected color based on slider values
        let color = UIColor(red: CGFloat(redSlider.value),
                            green: CGFloat(greenSlider.value),
                            blue: CGFloat(blueSlider.value),
                            alpha: 1.0)
        
        // Update text color of selected row based on sliders
        switch selectedIndexPath?.row {
        case 0:
            titleColor = color
        case 1:
            authorColor = color
        case 2:
            viewColor = color
        case 3:
            cellsColor = color
        default:
            break
        }
        
        // Update text color of selected cell
        if let selectedIndexPath = selectedIndexPath,
           let cell = tableView.cellForRow(at: selectedIndexPath) {
            cell.textLabel?.textColor = color
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.lightGray // Set cells background color
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // Save current colors
        UserDefaults.standard.set(color: titleColor!, forKey: "titleColor")
        UserDefaults.standard.set(color: authorColor!, forKey: "author")
        UserDefaults.standard.set(color: viewColor!, forKey: "viewColor")
        UserDefaults.standard.set(color: cellsColor!, forKey: "cellsColor")
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        // Reset colors to original values
        titleColor = UIColor.black
        authorColor = UIColor(displayP3Red: 255/255, green: 68/255, blue: 0/255, alpha: 1)
        viewColor = UIColor.white
        cellsColor = UIColor.white
        
        // Update sliders
        updateSliders(for: titleColor!)
        updateSliders(for: authorColor!)
        updateSliders(for: viewColor!)
        updateSliders(for: cellsColor!)
        
        // Reload table view
        tableView.reloadData()
    }
}
