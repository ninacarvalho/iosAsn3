//
//  EditQuestionViewController.swift
//  Asn3
//
//  Created by Marina Carvalho on 2024-11-12.
//

import UIKit

protocol QuestionBankDelegate: AnyObject {
    func didAddQuestion(_ question: Question)
    func didUpdateQuestion(_ question: Question, at index: Int)
}

class QuestionBuilderViewController: UIViewController {
    
    weak var delegate: QuestionBankDelegate?
    
    var editingIndex: Int?
    var questionToEdit: Question?
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var correctAnswerTextView: UITextView!
    @IBOutlet weak var wrongAnswer1TextView: UITextView!
    @IBOutlet weak var wrongAnswer2TextView: UITextView!
    @IBOutlet weak var wrongAnswer3TextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextViewStyle(questionTextView)
        setTextViewStyle(correctAnswerTextView)
        setTextViewStyle(wrongAnswer1TextView)
        setTextViewStyle(wrongAnswer2TextView)
        setTextViewStyle(wrongAnswer3TextView)

        
        if let question = questionToEdit {
           questionTextView.text = question.text
           correctAnswerTextView.text = question.correctAnswer
           wrongAnswer1TextView.text = question.wrongAnswers[0]
           wrongAnswer2TextView.text = question.wrongAnswers[1]
           wrongAnswer3TextView.text = question.wrongAnswers[2]
       }
        
    }
    
    @IBAction func CancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    func setTextViewStyle(_ textView: UITextView) {
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 5.0
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let questionText = questionTextView.text,
              let correctAnswer = correctAnswerTextView.text,
              let wrongAnswer1 = wrongAnswer1TextView.text,
              let wrongAnswer2 = wrongAnswer2TextView.text,
              let wrongAnswer3 = wrongAnswer3TextView.text else {
            return
        }
        
        let newQuestion = Question(
            text: questionText,
            correctAnswer: correctAnswer,
            wrongAnswers: [wrongAnswer1, wrongAnswer2, wrongAnswer3]
        )
        
        if let index = editingIndex {
            delegate?.didUpdateQuestion(newQuestion, at: index)
        } else {
            delegate?.didAddQuestion(newQuestion)
        }
        
        dismiss(animated: true, completion: nil)
    }

}
