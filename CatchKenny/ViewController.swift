//
//  ViewController.swift
//  CatchKenny
//
//  Created by Ian MacKinnon on 10/01/2023.
//

import UIKit

class ViewController: UIViewController {

    var score = 0
    var highscore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    @objc func initialise(){
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recogniser1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogniser9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recogniser1)
        kenny2.addGestureRecognizer(recogniser2)
        kenny3.addGestureRecognizer(recogniser3)
        kenny4.addGestureRecognizer(recogniser4)
        kenny5.addGestureRecognizer(recogniser5)
        kenny6.addGestureRecognizer(recogniser6)
        kenny7.addGestureRecognizer(recogniser7)
        kenny8.addGestureRecognizer(recogniser8)
        kenny9.addGestureRecognizer(recogniser9)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        let storedHighscore = UserDefaults.standard.object(forKey: "HIGHSCORE")
        if(storedHighscore == nil){
            highscore = 0
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        if let newScore = storedHighscore as? Int{
            highscore = newScore
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        
        initialise()
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
    }

    @objc func hideKenny(){
        
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countdown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if(counter == 0){
            timer.invalidate()
            hideTimer.invalidate()
            
    
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            if(score > highscore){
                highscore = score
                highscoreLabel.text = "Highscore: \(highscore)"
                UserDefaults.standard.set(highscore, forKey: "HIGHSCORE")
            }
            
            
            let alert = UIAlertController(title: "Time's Up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }

}

