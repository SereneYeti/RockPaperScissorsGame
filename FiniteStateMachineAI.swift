//
//  FiniteStateMachineAI.swift
//  RockPaperScissorsGame
//
//  Created by IACD-011 on 2022/05/24.
//

import Foundation

class FiniteStateMachineAI{
    var prevChoice:ThrowChoices?
    var prevWinner:Int = -999;
    
    var bestState:ThrowChoices?
    
    //States
    let stateRock = ThrowChoices.Rock;
    let statePaper = ThrowChoices.Paper;
    let stateScissors = ThrowChoices.Scissors;
    //
    
    init(){
        
    }
    
    public func DetermineState(prevWinner:Int){
        self.prevWinner = prevWinner
        if(prevChoice != nil)
        {
            EvaluateMove();
        }
        else {
            //If prevChoice is equal to nil this means that this is the first round and start with either paper or rock. i chose to start this with a random choice instead of a set choice like paper to make it harder to spot the AI pattern.
            if(Int.random(in: 1..<3) == 1){ bestState = statePaper; }
            else { bestState = stateRock; }
        }
        
    }
    
    public func EvaluateMove(){
        if(prevWinner == -1 || prevWinner == -999)
        {
            if(Int.random(in: 1..<3) == 1){ bestState = statePaper; }
            else { bestState = stateRock; }
        }
        else
        {
            bestState = GetNextState();
        }
       
    }
    
    func GetNextState()->ThrowChoices{
        var nextState:ThrowChoices;
        
        nextState = DetermineNextState(prevChoice!);
        
        return nextState;
    }
    
    func DetermineNextState(_ state:ThrowChoices)->ThrowChoices{
        if(prevWinner == 1 || prevWinner == 2)
        {
            if(state == stateRock){
                return stateScissors;
            }
            else if(state == statePaper){
                return stateRock;
            }
            else if(state == stateScissors){
                return statePaper;
            }
        }
        else if(prevWinner == 0)
        {
            if(state == stateRock){
                return statePaper;
            }
            else if(state == statePaper){
                return stateScissors;
            }
            else if(state == stateScissors){
                return stateRock;
            }
        }
        return statePaper;
    }
    
    public func GetMove()->ThrowChoices{
        prevChoice = bestState;
        return bestState!;
    }
}
