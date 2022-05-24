//
//  RPS_Play_ViewController.swift
//  RockPaperScissorsGame
//
//  Created by IACD-011 on 2022/05/24.
//

import UIKit

class RPS_Play_ViewController: UIViewController {
    
    enum ChosenAI {
    case RandomAI, FSM_AI
    }
    
    var chosenAI:ChosenAI = .RandomAI;
    var textColour:UIColor = UIColor.black;
    @IBOutlet weak var lblChosen_AI: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _PlayerAIChoice();

        // Do any additional setup after loading the view.
    }
    
    func _PlayerAIChoice() {
       switch (PlayerAIChoice) {
       case 0:
           print("Random AI")
           view.backgroundColor = .systemTeal
           chosenAI = ChosenAI.RandomAI;
           textColour = .systemIndigo
           lblChosen_AI.text = "Random AI";
           lblChosen_AI.textColor = textColour;
           break;
       case 1:
           print("FSM AI")
           view.backgroundColor = .systemPink
           chosenAI = ChosenAI.FSM_AI;
           textColour = UIColor.black;
           lblChosen_AI.text = "Finite State Machine AI";
           lblChosen_AI.textColor = textColour;
           break;
       case -1:
           print("no AI Chosen")
           //return to root page;
           self.navigationController?.popToRootViewController(animated: true);
           break;
       default:
           self.navigationController?.popToRootViewController(animated: true);
           break;
       }
   }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
