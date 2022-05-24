//
//  ViewController.swift
//  RockPaperScissorsGame
//
//  Created by IACD-011 on 2022/05/24.
//

import UIKit

public var PlayerAIChoice: Int = -1;

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PlayerAIChoice = -1;
    }

    @IBAction func btnRandomAI(_ sender: Any) {
        print("Random AI")
        PlayerAIChoice = 0;
    }
    
    @IBAction func btnFSM_AI(_ sender: Any) {
        print("Finite State Machine AI")
        PlayerAIChoice = 1;
    }
}

