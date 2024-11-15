import UIKit

protocol QuestionBankDelegate: AnyObject {
    func didAddQuestion(_ question: Question)
    func didUpdateQuestion(_ question: Question, at index: Int)
}

class QuestionBuilderViewController: UIViewController, UITextFieldDelegate {
    
    let maxCharacterLimit = 150
    
    weak var delegate: QuestionBankDelegate?
    
    var editingIndex: Int?
    var questionToEdit: Question?
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var wrongAnswer1TextField: UITextField!
    @IBOutlet weak var wrongAnswer2TextField: UITextField!
    @IBOutlet weak var wrongAnswer3TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textFields = [
               questionTextField,
               correctAnswerTextField,
               wrongAnswer1TextField,
               wrongAnswer2TextField,
               wrongAnswer3TextField
           ]
           
           for textField in textFields {
               textField?.delegate = self
               configureAsMultiline(textField)
           }
        
        
        // Pre-fill fields if editing a question
        if let question = questionToEdit {
            questionTextField.text = question.text
            correctAnswerTextField.text = question.correctAnswer
            wrongAnswer1TextField.text = question.wrongAnswers[0]
            wrongAnswer2TextField.text = question.wrongAnswers[1]
            wrongAnswer3TextField.text = question.wrongAnswers[2]
        }
    }
    
    @IBAction func CancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func configureAsMultiline(_ textField: UITextField?) {
        guard let textField = textField else { return }
        
        textField.borderStyle = .none
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 5.0
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 12
        textField.allowsEditingTextAttributes = true
        textField.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        // Set height constraint (optional)
        textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        textField.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let questionText = questionTextField.text,
              let correctAnswer = correctAnswerTextField.text,
              let wrongAnswer1 = wrongAnswer1TextField.text,
              let wrongAnswer2 = wrongAnswer2TextField.text,
              let wrongAnswer3 = wrongAnswer3TextField.text else {
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Move to the next text field or dismiss the keyboard
        if textField == questionTextField {
            correctAnswerTextField.becomeFirstResponder()
        } else if textField == correctAnswerTextField {
            wrongAnswer1TextField.becomeFirstResponder()
        } else if textField == wrongAnswer1TextField {
            wrongAnswer2TextField.becomeFirstResponder()
        } else if textField == wrongAnswer2TextField {
            wrongAnswer3TextField.becomeFirstResponder()
        } else if textField == wrongAnswer3TextField {
            textField.resignFirstResponder() // Dismiss the keyboard
        }
        return true
    }
}
