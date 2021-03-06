//
//  FirstScreenViewController.swift
//  CYOA-Bard-Adventure
//
//  Created by Austin Cole on 12/27/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDecisionModel.shared.currentSceneNumber = 0
        UserDecisionModel.shared.inventoryItems = []
    }

    @IBAction func nameSubmission(_ sender: Any) {
        
        guard let name = nameField.text, !name.isEmpty else {return}
        UserDecisionModel.shared.createHero(name: name)
        
    }
}
