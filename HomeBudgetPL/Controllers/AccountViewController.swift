//
//  ViewController.swift
//  HomeBudgetPL
//
//  Created by Marcin M on 25/04/2019.
//  Copyright © 2019 Marcin M. All rights reserved.
//

import UIKit
import RealmSwift

class AccountViewController: UIViewController, CanReceive {
    
    @IBOutlet weak var balanceView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ustawienie "<" do przemieszczania sie miedzy controllerami
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    @IBAction func incomeButttonPressed(_ sender: Any) {
        
    }
    
    @IBAction func expenseButtonPressed(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "settingsSegue" {
            
            let secondVC = segue.destination as! SettingsViewController
            
            secondVC.delegate = self
            
        }
    }
    
    func dataReceived(data: String) {
        balanceView.text = data
    }
    
}
