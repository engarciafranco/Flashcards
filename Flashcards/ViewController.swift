//
//  ViewController.swift
//  Flashcards
//
//  Created by Enrique Garcia on 10/13/18.
//  Copyright © 2018 Enrique Garcia. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    
   var flashcardsController: ViewController!
    
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var createQuestionBtn: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    // Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    // Current flashcard index
    var currentIndex = 0
    
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
        
        // Read saved flashcards
        readSavedFlashcards()
        
        // Update Flahscard Fucntion
        if flashcards.count == 0 {
            updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia", extraAnswerOne: "Sao Paulo", extraAnswerTwo: "Rio De Janeiro")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
    }

    // Reset Screen
    @IBAction func didTapOnFlashcard(_ sender: Any) {
//        frontLabel.isHidden = true
        if (frontLabel.isHidden == true) {
                frontLabel.isHidden = false;
                btnOptionOne.isHidden = false;
                btnOptionThree.isHidden = false;
                btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.4378522635, green: 0.6547383666, blue: 0.8708304763, alpha: 1)
        }
        
    }
    
    // Mutilpe Choice Options
    
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
    
    // Next and Prev Button Actions
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex - 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    // Update Labels Function
    func updateLabels() {
        // Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // Update label text
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    
    // Update Flahscard Function 
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?) {
        let flashcard = Flashcard(question: question, answer: answer)
        // Adding flashcards to the flashcard array
        flashcards.append(flashcard)
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
        
        // Logging to the console
        print("💁‍♀️ Flahscard added!")
        print("💁‍♀️ We now have \(flashcards.count) flashcards")
        
        // Update current index
        currentIndex = flashcards.count - 1
        print("💁‍♀️ Our current index is \(currentIndex)")
        
        // Update buttons
        updateNextPrevButtons()
        
        // Update labels
        updateLabels()
    }
    
    func updateNextPrevButtons() {
        
        // Disable the next button if at end
        if (currentIndex == flashcards.count - 1) {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        // Disavle prev button if at beginning
        if (currentIndex == 0) {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func saveAllFlashcardsToDisk() {
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(flashcards, forKey: "flashcards")
        // Log it
        print("Flashcards saved to USerDefaults")
    }
    
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            // In here we know for sure we have a dictionary array
            let savedCards = dictionaryArray.map{ dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            flashcards.append(contentsOf: savedCards)
        }
        
    }
    
    // Prepare for Segue Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        // Get the text from the existing flashcard.
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
       
        
    }
    
    
}

