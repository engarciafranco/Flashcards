//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Enrique Garcia on 10/28/18.
//  Copyright © 2018 Enrique Garcia. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerOneTextField: UITextField!
    @IBOutlet weak var extraAnswerTwoTextField: UITextField!
    var initialQuestion: String?
    var initialAnswer: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer 
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    @IBAction func didTapDone(_ sender: Any) {
        
        // Get the text in the question and answer text field.
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        
        let additionalOptionOne = extraAnswerOneTextField.text
        let additionalOptionTwo = extraAnswerTwoTextField.text
        
        
        // Check if empty
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty) {
            // Show error
            let alert = UIAlertController(title: "Missing text." , message: "You need to enter both a question and an answer", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
            // Update Flashcard
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: additionalOptionOne, extraAnswerTwo: additionalOptionTwo)
            dismiss(animated: true)
        }
        
       
        
    }
    
    
    

}
