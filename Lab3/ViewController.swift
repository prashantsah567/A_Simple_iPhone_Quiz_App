//
//  ViewController.swift
//  Lab3
//
//  Created by Prashant Shah on 4/24/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var qlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adding label******************************************************************
        let quizLabel = UILabel()
        quizLabel.translatesAutoresizingMaskIntoConstraints = false
        //adding label view to main view
        view.addSubview(quizLabel)
        
        //adding the margin and setting the height and width
        let margins = view.layoutMarginsGuide
        quizLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 50).isActive = true
        quizLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        quizLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        quizLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        quizLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        quizLabel.text = "QUIZ GAME"
        quizLabel.textAlignment = .center
        quizLabel.textColor = .white
        quizLabel.font = .italicSystemFont(ofSize: 20)
        
        // adding button*********************************************************************
        let startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        
        startButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        startButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //add title to the button
        startButton.setTitle("Start", for: .normal)
        //Change button title Font & Size
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //Change Button background color
        startButton.backgroundColor = UIColor.systemYellow
        //Change Button title color
        startButton.setTitleColor(UIColor.black, for: .normal)
       //Add tap action on Button
//        startButton.addTarget(self, action: Selector(("buttonTapped")),for: .touchUpInside)
//        func buttonTapped(sender: UIButton) {
//                print("Button tapped")
//        }
        startButton.addTarget(self, action: Selector(("openNextView")), for: .touchUpInside)
        
    }
    @objc @IBAction func openNextView(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "game")as!GameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

