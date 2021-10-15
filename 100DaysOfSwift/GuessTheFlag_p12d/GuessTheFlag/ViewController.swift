//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Elisey Ozerov on 30/09/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "score", style: .plain, target: self, action: #selector(showScore))
            
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Your score is", message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Thanks", style: .default))
        present(ac, animated: true)
    }
    
    func askQuestion(_ action: UIAlertAction! = nil) {
        questionsAsked += 1
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage.init(named: countries[0]), for: .normal)
        button2.setImage(UIImage.init(named: countries[1]), for: .normal)
        button3.setImage(UIImage.init(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased())"
    
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            score += 1
        } else {
            score -= 1
            let ac = UIAlertController(title: "Wrong!", message: "That's the flag of \(countries[sender.tag])", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default))
            present(ac, animated: true)
        }
        
        if questionsAsked < 10 {
            askQuestion()
        } else {
            var alertTitle = "Your final score"
            var alertMessage = "\(score)"
            let prevHighScore = getScore()
            if let prevHighScore = prevHighScore {
                if prevHighScore < score {
                    saveScore()
                    alertTitle = "New highscore!"
                    alertMessage = "Previous: \(prevHighScore)\nCurrent: \(score)"
                }
            } else {
                saveScore()
            }
            let ac = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
            questionsAsked = 0
        }
    }
    
    func saveScore() {
        UserDefaults.standard.set(score, forKey: "score")
    }
    
    func getScore() -> Int? {
        UserDefaults.standard.object(forKey: "score") as? Int
    }
    

}

