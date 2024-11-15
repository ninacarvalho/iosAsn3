//
//  MyQuizResultViewController.swift
//  Asn3
//
//  Created by Marina Carvalho on 2024-11-12.
//

import UIKit
class ResultViewController: UIViewController {
    
    // Property to receive the percentage of correct answers
    var correctPercentage: Float = 0.0
    
    // Outlet to display the result
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display the result
        resultLabel.text = "You answered \(correctPercentage)% of questions \n correctly."
    }
}
