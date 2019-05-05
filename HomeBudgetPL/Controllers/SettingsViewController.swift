//
//  SettingsViewController.swift
//  HomeBudgetPL
//
//  Created by Marcin M on 05/05/2019.
//  Copyright © 2019 Marcin M. All rights reserved.
//

import UIKit
import RealmSwift

protocol CanReceive {
    
    func dataReceived(data: String)
}

class SettingsViewController: UIViewController {
    
    var delegate : CanReceive?
    
    var balanceInit = 0
    
    let realm = try! Realm()
    
    
    @IBOutlet weak var initialBalanceView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialBalanceView.text = String(balanceInit)
        
    }
    
    @IBAction func initialBalanceButtonPressed(_ sender: Any) {
        
        delegate?.dataReceived(data: initialBalanceView.text!)
        
        let balanceInitRealm = Account()
        
        balanceInitRealm.initialBalance = 20
        
        try! realm.write {
            realm.add(balanceInitRealm, update: true)
            
        }
        
    }
    
}
