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
       }
    
    func addNewQuestion(_ question: Question) {
        questionBank.append(question)
    }
    
    func updateQuestion(_ question: Question, at index: Int) {
        questionBank[index] = question
    }
    
    
}
