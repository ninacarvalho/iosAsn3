//
//  QuestionBankListViewController.swift
//  Asn3
//
//  Created by Marina Carvalho on 2024-11-12.
//

import UIKit

class QuestionBankViewController: UIViewController, QuestionBankDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var questionBankTableView: UITableView!
    
    @IBOutlet weak var addQuestionButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionBankTableView.dataSource = self
        questionBankTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toQuestionBuilder", sender: self)
    }

    
    @IBAction func addQuestionTapped(_ sender: Any) {
        let questionBuilderViewController = QuestionBuilderViewController()
        questionBuilderViewController.delegate = self
               navigationController?.pushViewController(questionBuilderViewController, animated: true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionManager.shared.questionBank.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !QuestionManager.shared.questionBank.isEmpty else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "EmptyCell")
            cell.textLabel?.text = "No questions available"
            cell.textLabel?.textAlignment = .center
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionBankCell", for: indexPath)
        let question = QuestionManager.shared.questionBank[indexPath.row]
        cell.textLabel?.text = "\(question.text)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuestionBuilder" {
            if let questionBuilderViewController = segue.destination as? QuestionBuilderViewController {

                questionBuilderViewController.delegate = self
                
                if let selectedIndexPath = questionBankTableView.indexPathForSelectedRow {
                    questionBuilderViewController.editingIndex = selectedIndexPath.row
                    questionBuilderViewController.questionToEdit = QuestionManager.shared.questionBank[selectedIndexPath.row]
                }
            }
        }
    }

    
    func didAddQuestion(_ question: Question) {
        QuestionManager.shared.addNewQuestion(question)
        questionBankTableView.reloadData()
    }
    
    func didUpdateQuestion(_ question: Question, at index: Int) {
        QuestionManager.shared.updateQuestion(question, at: index)
    }
}


