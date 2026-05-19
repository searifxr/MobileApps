//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by Pothapragada, Krishna N on 10/2/25.
//

import Foundation

class TicTacToe{
    var board: [String] = Array(repeating:"" , count:9)
    
    var Player1Mark = "X"
    var Player2Mark = "O"
    var isPlayer1turn = true
    
    func setPlayer1mark(_ Mark: String){
        Player1Mark = Mark
        Player2Mark = (Player1Mark == "X") ? "O" : "X"
        isPlayer1turn = (Player1Mark == "X") ? true : false
    }
    
    func currentPlayerMark() -> String{
        return isPlayer1turn ? Player1Mark : Player2Mark
    }
    
    func MakeAMove(at index: Int) -> Bool {
        if index >= 0 && index <= 9 && board[index] == ""{
            board[index] = currentPlayerMark()
            return true
        }
        return false
    }
    func togglePlayer(){
        isPlayer1turn.toggle()
    }
    
    func checkWinner() -> String? {
        //Rows
        if board[0] != "" && board[0] == board[1] && board[1] == board[2] { return board[0]}
        if board[3] != "" && board[3] == board[4] && board[4] == board[5] { return board[3]}
        if board[6] != "" && board[6] == board[7] && board[7] == board[8] { return board[6]}
        
        //Diagonals
        if board[0] != "" && board[0] == board[4] && board[4] == board[8] { return board[0]}
        if board[6] != "" && board[6] == board[4] && board[4] == board[2] { return board[6]}
        
        //Columns
        if board[0] != "" && board[0] == board[3] && board[3] == board[6] { return board[0]}
        if board[1] != "" && board[1] == board[4] && board[4] == board[7] { return board[1]}
        if board[2] != "" && board[2] == board[5] && board[5] == board[8] { return board[2]}
        
        return nil
    }
    
    func ResetGame() {
        board = Array(repeating: "", count: 9)
        isPlayer1turn = true
    }
}
