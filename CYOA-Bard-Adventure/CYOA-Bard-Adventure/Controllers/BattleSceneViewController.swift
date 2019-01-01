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
        UserDecisionModel.shared.currentActionNumber = 1
        print(UserDecisionModel.shared.currentActionNumber)
        UserDecisionModel.shared.createMonster(name: "Goblin", health: 3)
        monsterHealthPointsLabel.text = "\(UserDecisionModel.shared.monsterHealth(damageTaken: nil))"
        herNameLabel.text = UserDecisionModel.shared.bardHero?.name
        heroHealthPointsLabel.text = "\(UserDecisionModel.shared.heroHealth(damageTaken: nil))"
        
        goodDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeActionSceneButtonTitles(condition: .good)), for: .normal)
        goodDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        badDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeActionSceneButtonTitles(condition: .bad)), for: .normal)
        badDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        neutralDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeActionSceneButtonTitles(condition: .neutral)), for: .normal)
        print(UserDecisionModel.shared.currentActionNumber)
        print(UserDecisionModel.shared.changeActionSceneButtonTitles(condition: .neutral))
        neutralDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func goodDecisionButtonAction(_ sender: Any) {
        UserDecisionModel.shared.currentActionNumber += 1
        guard let monsterHealth = UserDecisionModel.shared.monster?.healthPoints else {return}
        if monsterHealth <= 2 {
            UserDecisionModel.shared.monster?.healthPoints = 0
            UserDecisionModel.shared.monster?.isDead = true
        }
        else {
        goodDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeActionSceneButtonTitles(condition: .good)), for: .normal)
        monsterHealthPointsLabel.text = UserDecisionModel.shared.monsterHealth(damageTaken: .medium)
        goodDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBAction func badDecisionButtonAction(_ sender: Any) {
        UserDecisionModel.shared.currentActionNumber += 100
        guard let heroHealth = UserDecisionModel.shared.bardHero?.healthPoints else {return}
        guard let monsterHealth = UserDecisionModel.shared.monster?.healthPoints else {return}
        if heroHealth <= 2{
            UserDecisionModel.shared.bardHero?.healthPoints = 0
            UserDecisionModel.shared.bardHero?.isDead = true
        }
         else if monsterHealth <= 1 {
            UserDecisionModel.shared.monster?.healthPoints = 0
            UserDecisionModel.shared.monster?.isDead = true
        }
         
         else {
        badDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeActionSceneButtonTitles(condition: .bad)), for: .normal)
        heroHealthPointsLabel.text = UserDecisionModel.shared.heroHealth(damageTaken: .medium)
        monsterHealthPointsLabel.text = UserDecisionModel.shared.monsterHealth(damageTaken: .small)
        badDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBAction func neutralDecisionButtonAction(_ sender: Any) {
        UserDecisionModel.shared.currentActionNumber += 10000
        guard let heroHealth = UserDecisionModel.shared.bardHero?.healthPoints else {return}
        if heroHealth <= 1 {
            UserDecisionModel.shared.bardHero?.healthPoints = 0
            UserDecisionModel.shared.bardHero?.isDead = true
        }
        neutralDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeActionSceneButtonTitles(condition: .neutral)), for: .normal)
        heroHealthPointsLabel.text = UserDecisionModel.shared.heroHealth(damageTaken: .small)
        neutralDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goodHeroWins" || identifier == "badHeroWins" {
            if UserDecisionModel.shared.monster?.isDead == true {
                UserDecisionModel.shared.currentSceneNumber = 6
                return true
            }
        }
        return false
    }
}
