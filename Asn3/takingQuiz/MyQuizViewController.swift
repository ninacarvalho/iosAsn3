//
//  MyQuizViewController.swift
//  Asn3
//
//  Created by Marina Carvalho on 2024-11-12.
//

import UIKit

class MyQuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UITextView!
    
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var previousButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
        
    private var currentQuestionIndex = 0
    private var answeredQuestions = Set<Int>()
    private var correctAnswersCount = 0
    
    var questionBank: [Question] = QuestionManager.shared.questionBank

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadQuestion()
    }
    
    func setupUI() {
        progressView.progress = 0.0
    }
    
    
    func loadQuestion() {
        guard currentQuestionIndex < questionBank.count else {
            showQuizResult()
            return
        }
        
        let question = questionBank[currentQuestionIndex]
        questionLabel.text = question.text
        
        let answers = question.allAnswers
        option1Button.setTitle(answers[0], for: .normal)
        option2Button.setTitle(answers[1], for: .normal)
        option3Button.setTitle(answers[2], for: .normal)
        option4Button.setTitle(answers[3], for: .normal)
        
        let isAnswered = answeredQuestions.contains(currentQuestionIndex)
        [option1Button, option2Button, option3Button, option4Button].forEach { $0?.isEnabled = !isAnswered }
        
        updateProgress()
        previousButton.isEnabled = currentQuestionIndex > 0
        nextButton.isEnabled = currentQuestionIndex < questionBank.count
    }
    
  func updateProgress() {
      progressView.progress = Float(answeredQuestions.count) / Float(questionBank.count)
  }
  
  @IBAction func optionButtonTapped(_ sender: UIButton) {
      guard let selectedAnswer = sender.title(for: .normal) else { return }
      
      let correctAnswer = questionBank[currentQuestionIndex].correctAnswer
      if selectedAnswer == correctAnswer {
          correctAnswersCount += 1
      }
      
      answeredQuestions.insert(currentQuestionIndex)
      
      [option1Button, option2Button, option3Button, option4Button].forEach { $0?.isEnabled = false }
      
      updateProgress()
  }


    @IBAction func previousButtonTapped(_ sender: Any) {
        guard currentQuestionIndex > 0 else { return }
        currentQuestionIndex -= 1
        loadQuestion()
    }


    @IBAction func nextButtonTapped(_ sender: Any) {
        print("currentQuestionIndex: \(currentQuestionIndex) \n questionBank.count: \(questionBank.count )")
        guard currentQuestionIndex < questionBank.count else { return }
        currentQuestionIndex += 1
        loadQuestion()
    }

  
    func showQuizResult() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let resultVC = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController {
            let percentageCorrect = Float(correctAnswersCount) / Float(questionBank.count) * 100
            resultVC.correctPercentage = percentageCorrect
            
            self.navigationController?.pushViewController(resultVC, animated: true)
        } else {
            print("Error: Unable to instantiate MyQuizResultViewController.")
        }
    }




}
