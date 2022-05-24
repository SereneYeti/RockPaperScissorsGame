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
        
    var description : String {
               switch self {
               // Use Internationalization, as appropriate.
               case .RandomAI: return "Random AI"
               case .FSM_AI: return "Finite State Machine AI"
               }
            }
    }
    
    var chosenAI:ChosenAI = .RandomAI;
    
    enum ThrowChoices {
    case Rock, Paper, Scissors
        
    var description : String {
           switch self {
           // Use Internationalization, as appropriate.
           case .Rock: return "Rock"
           case .Paper: return "Paper"
           case .Scissors: return "Scissors"
           }
        }
    }
    //We give the AI a default value but not the player as we will always need a value for the AI even if the AI breaks otherwise we will break the program. While the Player cannot complete his turn without a value.
    var playerThrowChoice:ThrowChoices?
    var aiThrowCoice:ThrowChoices = .Paper;
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
        //print(playerThrowChoice!.description)
    }
    @IBOutlet weak var btnChoosePaper_Outlet: UIButton!
    @IBAction func btnChoosePaper(_ sender: Any) {
        playerThrowChoice = .Paper
        btnChooseScisors_Outlet.backgroundColor = .clear;
        btnChoosePaper_Outlet.backgroundColor = .systemGray;
        btnChooseRock_Outlet.backgroundColor = .clear;
        //print(playerThrowChoice!.description)
    }
    @IBOutlet weak var btnChooseScisors_Outlet: UIButton!
    @IBAction func btnChooseScissors(_ sender: Any) {
        playerThrowChoice = .Scissors
        btnChooseScisors_Outlet.backgroundColor = .systemGray;
        btnChoosePaper_Outlet.backgroundColor = .clear;
        btnChooseRock_Outlet.backgroundColor = .clear;
        //print(playerThrowChoice!.description)
    }
    func DoAIMove() {
        switch chosenAI {
        case .RandomAI:
            //Do Random AI
            aiThrowCoice = DoRandomAIMove();
            SetAIMoveChoiceLabel(aiThrowCoice);
            break;
        case .FSM_AI:
            //Do Finite State Machine AI
            break;
        }
    }
    func showTieAlert() {
        let alert = UIAlertController(title: "Tie", message: "The Match was a Tie! Throw Again!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             //print("Ok button tapped")
            alert.dismiss(animated: true, completion: nil)
          })
         
         //Add OK button to a dialog message
         alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    func showPlayerAlert() {
        let alert = UIAlertController(title: "The Player Wins!", message: "The player won the throw, check the tally!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             //print("Ok button tapped")
            alert.dismiss(animated: true, completion: nil)
          })
         
         //Add OK button to a dialog message
         alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    func showComputerAlert() {
        let alert = UIAlertController(title: "The Computer Wins!", message: "The Computer won the throw, check the tally!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             //print("Ok button tapped")
            alert.dismiss(animated: true, completion: nil)
          })
         
         //Add OK button to a dialog message
         alert.addAction(ok)

        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    @IBAction func btnMakeThrow(_ sender: Any) {
        
        if(iPlayerWins == 3 || iComputerWins == 3)
        {
            iComputerWins = 0;
            iPlayerWins = 0;
            BasicUISetup()
            lbl_AI_Choice.text = "AI Choice"
        }
        else
        {
            if(playerThrowChoice != nil){
                prevPlayerThrowChoice = playerThrowChoice;
                DoAIMove();
                print("Player Move: " + playerThrowChoice!.description)
                print("AI Move: " + aiThrowCoice.description)
                switch DetermineThrowWinner(Throw1: playerThrowChoice!, Throw2: aiThrowCoice) {
                case 0:
                    //This is a Tie
                    showTieAlert();
                    break;
                case 1:
                    //Throw1 in this case player 1 will win
                    showPlayerAlert()
                    iPlayerWins+=1;
                    BasicUISetup();
                    if(iPlayerWins == 3){
                        PlayerWins();
                        return;
                    }
                    break;
                case 2:
                    //Throw2 in this case teh computer will win
                    showComputerAlert()
                    iComputerWins+=1;
                    BasicUISetup();
                    if(iComputerWins == 3){
                        ComputerWins();
                        return;
                    }
                    break;
                default:
                    break;
                }
                btnChooseScisors_Outlet.backgroundColor = .clear;
                btnChoosePaper_Outlet.backgroundColor = .clear;
                btnChooseRock_Outlet.backgroundColor = .clear;
                playerThrowChoice = nil;
            }
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
           view.backgroundColor = .systemTeal
           chosenAI = ChosenAI.RandomAI;
           print(chosenAI.description)
           textColour = .systemIndigo
           lblChosen_AI.text = "Random AI";
           lblChosen_AI.textColor = textColour;
           break;
       case 1:
           view.backgroundColor = .systemPink
           chosenAI = ChosenAI.FSM_AI;
           print(chosenAI.description)
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
    
    //0 = tie, 1 = Throw1, 2 = Throw2
    func DetermineThrowWinner(Throw1:ThrowChoices,Throw2:ThrowChoices) -> Int {
        // < R < P < S
        //I.E Rock Beats Scissors, Paper Beats Rock, Scissors Beats Paper
        
        var ans:Int = 0;
        
        if(Throw1 == .Rock && Throw2 == .Paper){
            ans = 2;
        }
        else if(Throw1 == .Rock && Throw2 == .Scissors){
            ans = 1;
        }
        else if(Throw1 == .Rock && Throw2 == .Rock){
            ans = 0;
        }
        else if(Throw1 == .Scissors && Throw2 == .Paper){
            ans = 1;
        }
        else if(Throw1 == .Scissors && Throw2 == .Scissors){
            ans = 0;
        }
        else if(Throw1 == .Scissors && Throw2 == .Rock){
            ans = 2;
        }
        else if(Throw1 == .Paper && Throw2 == .Paper){
            ans = 0;
        }
        else if(Throw1 == .Paper && Throw2 == .Scissors){
            ans = 2;
        }
        else if(Throw1 == .Paper && Throw2 == .Rock){
            ans = 1;
        }
        
        
        
        return ans;
    }
    func SetAIMoveChoiceLabel(_ ThrowChoice:ThrowChoices){
        switch ThrowChoice {
        case .Rock:
            lbl_AI_Choice.text = sRock;
        case .Paper:
            lbl_AI_Choice.text = sPaper;
        case .Scissors:
            lbl_AI_Choice.text = sScissors;
        default:
            break;
        }
    }
    func DoRandomAIMove()->ThrowChoices{
        var ans:ThrowChoices = .Paper;
        
        let randInt = Int.random(in: 1...3)
        
        switch(randInt){
        case 1:
            ans = .Rock;
            return ans
        case 2:
            ans = .Paper;
            return ans
        case 3:
            ans = .Scissors;
            return ans
        default:
            return ans;
        }
    }
    func PlayerWins(){
        print("Player Wins!")
        lblGameTally.text = "Match Complete!\nThe player was the first to win 3 throws!"
        lbl_AI_Choice.text = "Press the Throw button to reset and play agin."
    }
    func ComputerWins(){
        print("Computer Wins!")
        lblGameTally.text = "Match Complete!\nThe computer was the first to win 3 throws!"
        lbl_AI_Choice.text = "Press the Throw button to reset and play agin."
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
