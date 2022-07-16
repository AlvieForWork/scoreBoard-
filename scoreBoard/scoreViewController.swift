//
//  scoreViewController.swift
//  scoreViewController
//
//  Created by worker on 2022/7/14.
//

import UIKit

class scoreViewController: UIViewController {
    
    //winnerLabel collecion
    @IBOutlet var winnerLabel: [UILabel]!
    //發球 collecion
    @IBOutlet var showServe: [UIView]!
    var index = Int.random(in: 0...1)
    //左邊
    @IBOutlet weak var leftScore: UILabel!
    @IBOutlet weak var leftName: UILabel!
    //右邊
    @IBOutlet weak var rightScore: UILabel!
    @IBOutlet weak var rightName: UILabel!
    //上面分數
    @IBOutlet weak var leftGameNumber: UILabel!
    @IBOutlet weak var rightGameNumber: UILabel!
    var leftGame:Int = 0
    var rightGame:Int = 0
    var score = Score(leftScoreA: 0, rightScoreB: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftName.text = "Team 1"
        rightName.text = "Team 2"
        showServe[index].isHidden = true
        winnerLabel[0].isHidden = true
        winnerLabel[1].isHidden = true

    }
    
    @IBAction func teamLGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left :
            score.leftScoreA += 1
            leftScore.text = "\(score.leftScoreA)"
            scoring(team: leftScore, score: score.leftScoreA, direction: .left, winner: nil)
            winnerLabel[0].isHidden = true
            winnerLabel[1].isHidden = true
            if score.leftScoreA <= 10 {
                viewChange()
            }
            if score.leftScoreA > 10 {
                deuceView()
            }
            
            
        case .right :
            score.leftScoreA -= 1
            if score.leftScoreA < 0 {
                score.leftScoreA = 0
            }
            scoring(team: leftScore, score: score.leftScoreA, direction: .right, winner: nil)
            
        default :
            scoring(team: leftScore, score: score.leftScoreA, direction: .left, winner: nil)
        }
        
        
        switch score.leftScoreA{
        case 0:
            score.rightScoreB = 0
            rightScore.text = "0\(score.rightScoreB)"
        case 10 :
            if score.rightScoreB == 10{
                deuce()
            }
        case 11 :
            if score.rightScoreB < 10 {
                leftGame += 1
                leftGameNumber.text = "\(leftGame)"
                scoring(team: leftScore, score: score.leftScoreA, direction: .left, winner: leftName.text)
                newGame()
            }
            
        default:
            if score.leftScoreA >= 10 , score.rightScoreB >= 10{
                deuce()
            }
        }
    }
    
    
    
    
    @IBAction func teamRGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left :
            score.rightScoreB += 1
            rightScore.text = "\(score.rightScoreB)"
            scoring(team: rightScore, score:score.rightScoreB, direction: .left, winner: nil)
            winnerLabel[0].isHidden = true
            winnerLabel[1].isHidden = true
            if score.rightScoreB <= 10{
                viewChange()
            }
            
            if score.rightScoreB > 10{
                deuceView()
            }
        case .right :
            score.rightScoreB -= 1
            if score.rightScoreB < 0 {
                score.rightScoreB = 0
            }
            scoring(team: rightScore, score: score.rightScoreB, direction: .right, winner: nil)
        default :
            scoring(team: rightScore, score: score.rightScoreB, direction: .left, winner: nil)
        }
        
        
        switch score.rightScoreB{
        case 0:
            score.rightScoreB = 0
            rightScore.text = "0\(score.rightScoreB)"
        case 10 :
            if score.rightScoreB == 10{
                deuce()
                
            }
        case 11 :
            if score.leftScoreA < 10{
                rightGame += 1
                rightGameNumber.text = "\(rightGame)"
                scoring(team: rightScore, score: score.rightScoreB, direction: .left, winner: rightName.text)
                newGame()
            }
            
        default:
            if score.leftScoreA >= 10 , score.rightScoreB >= 10{
                deuce()
            }
        }
    }
    
    
   
    
    
    
    
    @IBAction func changeSideBtn(_ sender: UIButton) {
        changeSide()
    }
    
    
    
    @IBAction func resetBtn(_ sender: UIButton) {
        endOfGame(winner: nil)
        viewChange()
        leftGame = 0
        rightGame = 0
        leftGameNumber.text = "0"
        rightGameNumber.text = "0"
        leftName.text = "Team 1"
        rightName.text = "Team 2"
        winnerLabel[0].isHidden = true
        winnerLabel[1].isHidden = true
        newGame()
    }
    

    
// 新的一局
    func newGame() {
        score.leftScoreA = 0
        score.rightScoreB = 0
        leftScore.text = "00"
        rightScore.text = "00"
        
        if leftName.text == "Team 1"{
            leftName.text = "Team 1"
        }else if leftName.text == "Team 2"{
            leftName.text = "Team 2"
        }else if rightName.text == "Team 1" {
            rightName.text = "Team 1"
        }else if rightName.text == "Team 2" {
            rightName.text = "Team 2"
        }
    }
    
    //輪替發球 分數加2次後輪替
    func viewChange() {
        if showServe[0].isHidden == true{
            let sum = score.leftScoreA + score.rightScoreB
            //左邊加右邊分數總和是2 就要輪替
            if sum % 2 == 0 {
                showServe[1].isHidden = true
                showServe[0].isHidden = false
            }else{
                showServe[1].isHidden = false
                showServe[0].isHidden = true
            }
        }else if showServe[0].isHidden == false{
            let sum = score.leftScoreA + score.rightScoreB
            if sum % 2 == 0 {
                showServe[0].isHidden = true
                showServe[1].isHidden = false
            }else{
                showServe[0].isHidden = false
                showServe[1].isHidden = true
            }
        }

    }
    
    //deuce 的輪替
    func deuceView(){
        if showServe[0].isHidden == false{
            let sum = score.leftScoreA - score.rightScoreB
            if sum  != 1 || sum == 0 || sum == 1{
                showServe[1].isHidden = false
                showServe[0].isHidden = true
            }
        }else{
            let sum = score.leftScoreA - score.rightScoreB
            if sum != 1 || sum == 0 || sum == 1{
                showServe[1].isHidden = true
                showServe[0].isHidden = false
            }
        }
    }
    
    
   //UIAlert
    func AlertLeft() {
        let controller = UIAlertController(title: "好棒！", message: "Team 1 獲勝！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "結束", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
        newGame()
    }
    
    func AlertRight() {
        let controller = UIAlertController(title: "好棒!", message: "Team 2 獲勝！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "結束", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
        newGame()
    }
    
    
    // 判斷誰是獲勝者
    func endOfGame(winner:String?){
        if winner == leftName.text {
            winnerLabel[0].isHidden = false
            winnerLabel[1].isHidden = true
            if leftName.text == "Team 1"{
                AlertLeft()
            }else if leftName.text == "Team 2"{
                AlertRight()
            }
        }else if winner == rightName.text {
            winnerLabel[0].isHidden = true
            winnerLabel[1].isHidden = false
            if rightName.text == "Team 1"{
                AlertLeft()
            }else if rightName.text == "Team 2"{
                AlertRight()
            }
        }
    }
    
 
    
    //判斷得分結果，設定參數：得分隊伍、分數、滑動方向、贏球隊伍，判斷比賽是否結束
    func scoring(team:UILabel,score:Int,direction:UISwipeGestureRecognizer.Direction,winner:String?){
        if direction == .left{
            if score == 11{
                endOfGame(winner: winner)
                team.text = "\(score)"
            }else{
                if score < 10 {
                    team.text = "0\(score)"
                }else{
                    team.text = "\(score)"
                }
            }
        }else{
            if score == 0 {
                team.text = "00"
            }else{
                if score < 10 {
                    team.text = "0\(score)"
                }else{
                    team.text = "\(score)"
                }
            }
        }
    }
    
    func deuce(){
        let sum = score.leftScoreA - score.rightScoreB
        let sum2 = score.rightScoreB - score.leftScoreA
        if sum == 2 {
            winnerLabel[0].isHidden = false
            winnerLabel[1].isHidden = true
            leftGame += 1
            leftGameNumber.text = "\(leftGame)"
            //UIAlert
            if leftName.text == "Team 1"{
                AlertLeft()
            }else if leftName.text == "Team 2"{
                AlertRight()
            }
            
        }else if sum2 == 2{
            winnerLabel[1].isHidden = false
            winnerLabel[0].isHidden = true
            rightGame += 1
            rightGameNumber.text = "\(rightGame)"
            if rightName.text == "Team 1"{
                AlertLeft()
            }else if rightName.text == "Team 2"{
                AlertRight()
            }
        }
    }
    
    
    func changeSide() {
        let changeGLNum = leftGame
        let changeGRNum = rightGame
        
        let changeLNum = score.leftScoreA
        let changeRNum = score.rightScoreB
        
        let changeLGame = leftGameNumber.text
        let changeRGame = rightGameNumber.text
        
        let changeLScore = leftScore.text
        let changeRScore = rightScore.text
        
        leftGame = changeGRNum
        rightGame = changeGLNum
        
        score.leftScoreA = changeRNum
        score.rightScoreB = changeLNum
        
        leftGameNumber.text = changeRGame
        rightGameNumber.text = changeLGame
        
        leftScore.text = changeRScore
        rightScore.text = changeLScore
        
        if showServe[0].isHidden == true {
            showServe[0].isHidden = false
            showServe[1].isHidden = true
        }else if showServe[1].isHidden == true {
            showServe[1].isHidden = false
            showServe[0].isHidden = true
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    

 

}
