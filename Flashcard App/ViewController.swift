//
//  ViewController.swift
//  Flashcard App
//
//  Created by iD Student on 8/2/17.
//  Copyright © 2017 Lapo Veca. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerPickerView: UIPickerView!
    @IBOutlet weak var questionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        answerPickerView.dataSource = self
        answerPickerView.delegate = self
        
        setupCardUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupCardUI() {
        questionTextView.text = CardCollection.instance.currentCard.question
        questionLabel.text = "Question \(CardCollection.instance.currentIndex + 1)/\(CardCollection.instance.cards.count)"
        
        answerPickerView.reloadAllComponents()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CardCollection.instance.currentCard.options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CardCollection.instance.currentCard.options[row];
    }
    
    
    @IBAction func submitButtonPressed(_ sender: Any) {
    
        var alert : UIAlertController
        
        if(CardCollection.instance.checkAnswer(selectedAnswer: answerPickerView.selectedRow(inComponent: 0))) {
            alert = UIAlertController(title: "Correct!", message:"Correct Answer!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yay!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            alert = UIAlertController(title: "Incorrect!", message:"Incorrect Answer!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Aww!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)

        }
    
    CardCollection.instance.nextQuestion()
        
    setupCardUI()
        
        
    }
    
}
