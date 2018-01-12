//
//  ViewController.swift
//  Quiz
//
//  Created by Susan Kamies on 20/09/2017.
//  Copyright © 2017 Susan Kamies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestinLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    //MARK: Properties
    let questions: [String] = [
        "Hoeveel is 7+7?",
        "Wat is de hoofdstad van Vermont?",
        "Waar is Cognac van gemaakt?"
    ]
    
    let answers: [String] = [
        "14",
        "Montpelier",
        "Druiven"
    ]
    
    var currentQuestionIndex = 0
    
    
    //MARK: Actions
    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count{
            currentQuestionIndex = 0
        }
        
        let question = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        animateLabelTransistions()
        
    }
    @IBAction func showAnswer(_ sender: UIButton) {
        let answer = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        updateOffScreenLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    func animateLabelTransistions() {
        //Forceer elke layout verandering die moet plaatsvinden om eerst plaats te vinden
        
        view.layoutIfNeeded()
        
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestinLabelCenterXConstraint.constant += screenWidth
        
        
        //Spring animatie
        //        UIView.animate(
        //            withDuration: 0.5,
        //            delay: 0,
        //            usingSpringWithDamping: 0.2,
        //            initialSpringVelocity: 0.2,
        //            options: [],
        //            animations: {
        //                self.currentQuestionLabel.alpha = 0
        //                self.nextQuestionLabel.alpha = 1
        //
        //                self.view.layoutIfNeeded()
        //        },
        //            completion: { _ in
        //                swap(&self.currentQuestionLabel,
        //                     &self.nextQuestionLabel)
        //                swap(&self.currentQuestinLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
        //                self.updateOffScreenLabel()
        //        })
        
        //        Verschuivingsanimatie
        //Animeer de alpha en de center x constraints
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [.curveLinear],
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                
                self.view.layoutIfNeeded()
        },
            completion: { _ in
                swap(&self.currentQuestionLabel,
                     &self.nextQuestionLabel)
                swap(&self.currentQuestinLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                self.updateOffScreenLabel()
        })
    }
}

