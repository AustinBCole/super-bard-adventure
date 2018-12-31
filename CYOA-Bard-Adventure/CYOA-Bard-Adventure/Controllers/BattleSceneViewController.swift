//
//  BattleSceneViewController.swift
//  CYOA-Bard-Adventure
//
//  Created by Austin Cole on 12/29/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class BattleSceneViewController: UIViewController {
    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var monsterNameLabel: UILabel!
    @IBOutlet weak var monsterHealthPointsLabel: UILabel!
    @IBOutlet weak var heroHeroView: UIImageView!
    @IBOutlet weak var herNameLabel: UILabel!
    @IBOutlet weak var heroHealthPointsLabel: UILabel!
    @IBOutlet weak var goodDecisionButton: UIButton!
    @IBOutlet weak var badDecisionButton: UIButton!
    @IBOutlet weak var neutralDecisionButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        monsterHealthPointsLabel.text = "5"
        herNameLabel.text = UserDecisionModel.shared.bardHero?.name
        
        goodDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .good)), for: .normal)
        goodDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        badDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .bad)), for: .normal)
        badDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        neutralDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .neutral)), for: .normal)
        neutralDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }

}
