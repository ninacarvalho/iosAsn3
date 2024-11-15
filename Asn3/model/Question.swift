//
//  Question.swift
//  Asn3
//
//  Created by Marina Carvalho on 2024-11-12.
//

import Foundation

struct Question {
    let text: String
    let correctAnswer: String
    let wrongAnswers: [String]
    
    var allAnswers: [String] {
        return (wrongAnswers + [correctAnswer]).shuffled()
    }
}

class QuestionManager {
    public static var shared = QuestionManager()
    
    var questionBank = [Question]()
    
    // Initializer to populate questionBank with sample questions
       public init() {
           questionBank = [
               Question(
                   text: "What is the capital of France?",
                   correctAnswer: "Paris",
                   wrongAnswers: ["Berlin", "Madrid", "Rome"]
               ),
               Question(
                   text: "What is the largest planet in our solar system?",
                   correctAnswer: "Jupiter",
                   wrongAnswers: ["Earth", "Mars", "Saturn"]
               ),
               Question(
                   text: "Who wrote 'Romeo and Juliet'?",
                   correctAnswer: "William Shakespeare",
                   wrongAnswers: ["Charles Dickens", "Jane Austen", "Mark Twain"]
               ),
               Question(
                   text: "Which element has the chemical symbol 'O'?",
                   correctAnswer: "Oxygen",
                   wrongAnswers: ["Osmium", "Ozone", "Oxygenium"]
               ),
               Question(
                   text: "What is the speed of light?",
                   correctAnswer: "299,792 km/s",
                   wrongAnswers: ["150,000 km/s", "1,000,000 km/s", "3,000 km/s"]
               )
           ]
       }
    
    func addNewQuestion(_ question: Question) {
        questionBank.append(question)
    }
    
    func updateQuestion(_ question: Question, at index: Int) {
        questionBank[index] = question
    }
    
    
}
