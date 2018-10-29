//
//  ViewController.swift
//  Flashcards
//
//  Created by Enrique Garcia on 10/13/18.
//  Copyright © 2018 Enrique Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   var flashcardsController: ViewController!
    
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var createQuestionBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        card.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.4
       
        backLabel.clipsToBounds = true;
        frontLabel.clipsToBounds = true
        
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.4378522635, green: 0.6547383666, blue: 0.8708304763, alpha: 1)
        btnOptionOne.layer.cornerRadius = 15.0
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.4378522635, green: 0.6547383666, blue: 0.8708304763, alpha: 1)
        btnOptionTwo.layer.cornerRadius = 15.0
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.4378522635, green: 0.6547383666, blue: 0.8708304763, alpha: 1)
        btnOptionThree.layer.cornerRadius = 15.0
        
        createQuestionBtn.layer.cornerRadius = 25.0
        createQuestionBtn.layer.shadowRadius = 8.0
        createQuestionBtn.layer.shadowOpacity = 0.2
        
        
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
//        frontLabel.isHidden = true
        if (frontLabel.isHidden == true) {
                frontLabel.isHidden = false;
                btnOptionOne.isHidden = false;
                btnOptionThree.isHidden = false;
                btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.4378522635, green: 0.6547383666, blue: 0.8708304763, alpha: 1)
        }
        
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
    
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
        backLabel.text = answer
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    
}

