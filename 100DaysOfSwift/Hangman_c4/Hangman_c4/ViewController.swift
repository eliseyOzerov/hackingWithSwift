//
//  ViewController.swift
//  Hangman_c4
//
//  Created by Elisey Ozerov on 11/10/2021.
//

import UIKit

class ViewController: UIViewController {
    var attemptsLabel = UILabel()
    var answerLabel = UILabel()
    var input = UITextField()
    var button = UIButton(type: .system)
    
    var guessedLetters = [String]()
    
    var attempts = 7 {
        didSet {
            attemptsLabel.text = attempts.description
        }
    }
    
    var answer: String!
    var answerLabelText: String! {
        didSet {
            answerLabel.attributedText = NSAttributedString(
                string: answerLabelText,
                attributes: [.kern: 10, .font: UIFont.systemFont(ofSize: 36, weight: .light)]
            )
        }
    }
    
    var guessedLetter: String!
    
    var answers = [
//        "frozen",
//        "inject",
//        "slogan",
//        "weapon",
//        "cheese",
//        "dealer",
//        "player",
//        "burial",
//        "orange",
//        "gutter",
        "valley",
//        "sacred",
//        "stride",
//        "devote",
//        "cattle",
//        "period",
//        "canvas",
//        "cancer",
//        "wealth",
//        "future",
//        "pigeon",
//        "summit",
//        "barrel",
//        "method",
//        "locate",
//        "temple",
//        "shiver",
//        "circle",
//        "profit",
//        "attack",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(newGame))
        newGame()
        setupViews()
    }
    
    @objc func newGame() {
        answers.shuffle()
        answer = answers.randomElement()
        attempts = 7
        answerLabelText = "______"
        guessedLetter = nil
        input.text = ""
    }
    
    @objc func guess() {
        guessedLetter = input.text?.lowercased()
        if (guessedLetters.contains(guessedLetter)) {
            let ac = UIAlertController(title: "Oops!", message: "You've already guessed that one", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
            return
        }
        guessedLetters.append(guessedLetter)
        var sequence = Array(answerLabelText)
        for (index, char) in answer.enumerated() {
            if (String(char) == guessedLetter) {
                sequence[index] = Character(guessedLetter)
            }
        }
        let newAnswerLabelText = String(sequence)
        
        if (answerLabelText == newAnswerLabelText) {
            attempts -= 1
            if (attempts == 0) {
                let ac = UIAlertController(title: "You lost.", message: "Sucks to be you!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Gee thanks", style: .default) { [weak self] _ in self?.newGame() })
                present(ac, animated: true)
            }
        } else {
            answerLabelText = newAnswerLabelText
            if (answerLabelText == answer) {
                let ac = UIAlertController(title: "You won!", message: "Congrats buddy", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Gee thanks", style: .default) { [weak self] _ in self?.newGame() })
                present(ac, animated: true)
            }
        }
        input.text = ""
    }
}

// we need an input, a submit button, a text showing the word and attempts left

extension ViewController {
    func setupViews() {
        setupAttemptsView()
        setupAnswerView()
        setupInputView()
        setupButtonView()
    }
    
    func setupAttemptsView() {
        view.addSubview(attemptsLabel)
        attemptsLabel.text = attempts.description
        attemptsLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        attemptsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            attemptsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            attemptsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
    }
    
    func setupAnswerView() {
        view.addSubview(answerLabel)
        answerLabel.attributedText = NSAttributedString(
            string: answerLabelText,
            attributes: [.kern: 10, .font: UIFont.systemFont(ofSize: 36, weight: .light)]
        )
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerLabel.topAnchor.constraint(equalTo: attemptsLabel.bottomAnchor, constant: 40),
        ])
    }
    
    func setupInputView() {
        view.addSubview(input)
        input.placeholder = "Guess a letter"
        input.font = UIFont.systemFont(ofSize: 24, weight: .light)
        input.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            input.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            input.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 60),
        ])
    }
    
    func setupButtonView() {
        view.addSubview(button)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(guess), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: input.bottomAnchor, constant: 40)
        ])
    }
}
