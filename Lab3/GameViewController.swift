//
//  GameViewController.swift
//  Lab3
//
//  Created by Prashant Shah on 4/25/22.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //storing the collection of questions in an array
    var gameModels = [Question]()
    //signifies question for the current level
    var currentQuestion: Question?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting up table view
        table.delegate = self
        table.dataSource = self
        setupQuestions()
        configureUI(question: gameModels.first!)
    }
    
    //setting the UI component for question and answer part
    private func configureUI(question: Question){
        //setting view for questions
        label.text = question.text
        currentQuestion = question
        table.reloadData()
    }
    //declaring a function to check the answer supplied is correct
    private func checkAnswer(answer: Answer, question: Question) -> Bool{
        return question.answers.contains(where: { $0.text == answer.text}) && answer.correct
    }
    
    //setting up the questions and answers and storing them into gameModels
    private func setupQuestions(){
        gameModels.append(Question(text: "What owns twitter?", answers: [
        Answer(text: "Jack", correct: false),
        Answer(text: "Elon", correct: true),
        Answer(text: "Parag", correct: false),
        Answer(text: "Jeff", correct: false),
        ]))
        
        gameModels.append(Question(text: "What is the captial city of USA?", answers: [
        Answer(text: "New York", correct: false),
        Answer(text: "Boston", correct: false),
        Answer(text: "Los Angles", correct: false),
        Answer(text: "Washington DC", correct: true),
        ]))
        
        gameModels.append(Question(text: "Who is the current president of USA?", answers: [
        Answer(text: "Trump", correct: false),
        Answer(text: "Obama", correct: false),
        Answer(text: "Biden", correct: true),
        Answer(text: "Bill", correct: false),
        ]))
        
        gameModels.append(Question(text: "What is the nearest star from earth?", answers: [
        Answer(text: "Sirus", correct: false),
        Answer(text: "Proxima", correct: false),
        Answer(text: "Sun", correct: true),
        Answer(text: "Kepler", correct: false),
        ]))
        
        gameModels.append(Question(text: "What company works for space travel?", answers: [
        Answer(text: "ebay", correct: false),
        Answer(text: "Geico", correct: false),
        Answer(text: "SpaceX", correct: true),
        Answer(text: "Microsoft", correct: false),
        ]))
    }
    
    //table view functions
    //1st function for the number of rows in section if nothing then 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    //2nd function create and return cells for the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }
    //3rd function get called when we select an answer
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //unwrap current question to make sure it's not nil
        guard let question = currentQuestion else{
            return
        }
        let answer = question.answers[indexPath.row]
        
        if checkAnswer(answer: answer ,question: question){
            //correct
            if let index = gameModels.firstIndex(where: {$0.text == question.text}){
                if index < (gameModels.count - 1){
                    //next question
                    let nextQuestion = gameModels[index+1]
                    configureUI(question: nextQuestion)
                    table.reloadData()
                }
                else{
                    //end of game
                    let vc = storyboard?.instantiateViewController(withIdentifier: "win")as!WinViewController
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true)
                }
            }
            
        }
        else{
            //wrong
            let alert = UIAlertController(title: "Wrong", message: "Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
}

//two kinds of objects representing questions and answers
struct Question{
    let text: String
    let answers: [Answer] //array of answer objects
}

struct Answer{
    let text: String
    let correct: Bool //either true or false
}
