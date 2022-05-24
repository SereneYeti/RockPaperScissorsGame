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
    
    enum ThrowChoices {
    case Rock, Paper, Scissors
    }
    var playerThrowChoice:ThrowChoices?
    var prevPlayerThrowChoice:ThrowChoices?
    var iPlayerWins:Int = 0;
    var iComputerWins:Int = 0;
    
    let sRock = "🪨";
    let sPaper = "📜";
    let sScissors = "✂️"
    var textColour:UIColor = UIColor.black;
    
    @IBOutlet weak var lblChosen_AI: UILabel!
    @IBOutlet weak var lbl_AI_Choice: UILabel!
    @IBOutlet weak var lblGameTally: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _PlayerAIChoice();
        
        BasicUISetup();

        iPlayerWins = 0;
        iComputerWins = 0;
    }
    @IBOutlet weak var btnChooseRock_Outlet: UIButton!
    @IBAction func btnChooseRock(_ sender: Any) {
        playerThrowChoice = .Rock;
        btnChooseRock_Outlet.backgroundColor = .systemGray;
        btnChooseScisors_Outlet.backgroundColor = .clear;
        btnChoosePaper_Outlet.backgroundColor = .clear;
        print("Rock")
    }
    @IBOutlet weak var btnChoosePaper_Outlet: UIButton!
    @IBAction func btnChoosePaper(_ sender: Any) {
        playerThrowChoice = .Paper
        btnChooseScisors_Outlet.backgroundColor = .clear;
        btnChoosePaper_Outlet.backgroundColor = .systemGray;
        btnChooseRock_Outlet.backgroundColor = .clear;
        print("Paper")
    }
    @IBOutlet weak var btnChooseScisors_Outlet: UIButton!
    @IBAction func btnChooseScissors(_ sender: Any) {
        playerThrowChoice = .Scissors
        btnChooseScisors_Outlet.backgroundColor = .systemGray;
        btnChoosePaper_Outlet.backgroundColor = .clear;
        btnChooseRock_Outlet.backgroundColor = .clear;
        print("Scissors")
    }
    @IBAction func btnMakeThrow(_ sender: Any) {
        if(playerThrowChoice != nil){
            prevPlayerThrowChoice = playerThrowChoice;
            playerThrowChoice = nil;
        }
    }
    @IBAction func btnReturnMainMenu(_ sender: Any) {
        //Return to Main Menu
        //print("Returning to Main Menu");
        self.dismiss(animated: true, completion: nil)
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
           self.dismiss(animated: true, completion: nil)
       default:
           self.dismiss(animated: true, completion: nil)
       }
   }
    
    func BasicUISetup() -> Void {
        
        btnChooseRock_Outlet.titleLabel?.adjustsFontSizeToFitWidth = true;
        btnChooseScisors_Outlet.titleLabel?.adjustsFontSizeToFitWidth = true;
        btnChoosePaper_Outlet.titleLabel?.adjustsFontSizeToFitWidth = true;
        
        lbl_AI_Choice.textColor = textColour;
        lblGameTally.text = "Best of 3- Tally:\nPlayer Wins: " + String(iPlayerWins) + "\nAI Wins: " + String(iComputerWins);
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
