//
//  AT1ExerciseTableViewController.swift
//  TesteDiagnostico
//
//  Created by Kaique Damato on 8/8/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit
import AVFoundation

class AT1ExerciseTableViewController: UITableViewController {
    
    @IBOutlet weak var sqOneNbOneLabel: UILabel!
    @IBOutlet weak var sqOneNbTwoLabel: UILabel!
    @IBOutlet weak var sqOneNbThreeLabel: UILabel!
    @IBOutlet weak var sqOneNbFourLabel: UILabel!
    @IBOutlet weak var sqOneNbFiveLabel: UILabel!
    @IBOutlet weak var correctOneButton: KPButton!
    @IBOutlet weak var wrongOneButton: KPButton!
    
    @IBOutlet weak var sqTwoNbOneLabel: UILabel!
    @IBOutlet weak var sqTwoNbTwoLabel: UILabel!
    @IBOutlet weak var sqTwoNbThreeLabel: UILabel!
    @IBOutlet weak var correctTwoButton: KPButton!
    @IBOutlet weak var wrongTwoButton: KPButton!
    
    @IBOutlet weak var voiceButton: KPButton!
    
    @IBOutlet weak var choiceOneButton: KPButton!
    @IBOutlet weak var choiceTwoButton: KPButton!
    
    var sequenceOne = [UILabel]()
    var sequenceTwo = [UILabel]()
    let attentionModel = AT1ExerciseExtension()
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    var pointsInExerciseOne = 0
    var pointsInExerciseTwo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sequenceOne = [sqOneNbOneLabel, sqOneNbTwoLabel, sqOneNbThreeLabel, sqOneNbFourLabel, sqOneNbFiveLabel]
        sequenceTwo = [sqTwoNbOneLabel, sqTwoNbTwoLabel, sqTwoNbThreeLabel]
        
        self.configurateSequences()
    }

    func configurateSequences() {
        let sequenceNumbersOne = attentionModel.getFirstSequence()
        let sequenceNumbersTwo = attentionModel.getSecondSequence()
        
        self.populateSequence(sequenceNumbersOne, labels: sequenceOne)
        self.populateSequence(sequenceNumbersTwo, labels: sequenceTwo)
    }
    
    func populateSequence(numbers: [String], labels: [UILabel]) {
        for var index = 0; index < labels.count; index++ {
            labels[index].text = numbers[index]
        }
    }
    
    @IBAction func textToSpeech(sender: KPButton) {
        let buttonTag = sender.tag
        
        if buttonTag == 0 {
            for number in sequenceOne {
                self.speech(number)
            }
        } else if buttonTag == 1 {
            for number in sequenceTwo {
                self.speech(number)
            }
        }
    }
    
    func speech(number: UILabel) {
        myUtterance = AVSpeechUtterance(string: number.text)
        myUtterance.rate = 0.1
        myUtterance.postUtteranceDelay = 0.6
        synth.speakUtterance(myUtterance)
    }
    
    @IBAction func firstAnswer(sender: KPButton) {
        if sender.tag == 1 {
            pointsInExerciseOne = sender.tag
            sender.backgroundColor = UIColor(red: 22/255, green: 142/255, blue: 234/255, alpha: 1)
            wrongOneButton.backgroundColor = UIColor(red: 15/255, green: 20/255, blue: 65/255, alpha: 1)
        } else if sender.tag == 0 {
            pointsInExerciseOne = sender.tag
            sender.backgroundColor = UIColor(red: 22/255, green: 142/255, blue: 234/255, alpha: 1)
            correctOneButton.backgroundColor = UIColor(red: 15/255, green: 20/255, blue: 65/255, alpha: 1)
        }
    }
    
    @IBAction func secondAnswer(sender: KPButton) {
        if sender.tag == 1 {
            pointsInExerciseTwo = sender.tag
            sender.backgroundColor = UIColor(red: 22/255, green: 142/255, blue: 234/255, alpha: 1)
            wrongTwoButton.backgroundColor = UIColor(red: 15/255, green: 20/255, blue: 65/255, alpha: 1)
        } else if sender.tag == 0 {
            pointsInExerciseTwo = sender.tag
            sender.backgroundColor = UIColor(red: 22/255, green: 142/255, blue: 234/255, alpha: 1)
            correctTwoButton.backgroundColor = UIColor(red: 15/255, green: 20/255, blue: 65/255, alpha: 1)
        }
    }
    
    @IBAction func stopSpeech() {
        self.synth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
    }
}
