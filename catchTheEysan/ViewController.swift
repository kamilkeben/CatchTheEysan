//
//  ViewController.swift
//  catchTheEysan
//
//  Created by KamilKeben on 11.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var eysanArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    @IBOutlet weak var timeLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var highscoreLabel : UILabel!
    
    
    @IBOutlet weak var eysan1 : UIImageView!
    @IBOutlet weak var eysan2 : UIImageView!
    @IBOutlet weak var eysan3 : UIImageView!
    @IBOutlet weak var eysan4 : UIImageView!
    @IBOutlet weak var eysan5 : UIImageView!
    @IBOutlet weak var eysan6 : UIImageView!
    @IBOutlet weak var eysan7 : UIImageView!
    @IBOutlet weak var eysan8 : UIImageView!
    @IBOutlet weak var eysan9 : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        //Highscore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
            
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        eysan1.isUserInteractionEnabled = true
        eysan2.isUserInteractionEnabled = true
        eysan3.isUserInteractionEnabled = true
        eysan4.isUserInteractionEnabled = true
        eysan5.isUserInteractionEnabled = true
        eysan6.isUserInteractionEnabled = true
        eysan7.isUserInteractionEnabled = true
        eysan8.isUserInteractionEnabled = true
        eysan9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        eysan1.addGestureRecognizer(recognizer1)
        eysan2.addGestureRecognizer(recognizer2)
        eysan3.addGestureRecognizer(recognizer3)
        eysan4.addGestureRecognizer(recognizer4)
        eysan5.addGestureRecognizer(recognizer5)
        eysan6.addGestureRecognizer(recognizer6)
        eysan7.addGestureRecognizer(recognizer7)
        eysan8.addGestureRecognizer(recognizer8)
        eysan9.addGestureRecognizer(recognizer9)
        
        eysanArray = [eysan1, eysan2, eysan3, eysan4, eysan5, eysan6, eysan7, eysan8, eysan9]
        
        //Timer
        counter = 10
        timeLabel.text = String (counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideEysan), userInfo: nil, repeats: true)
        hideEysan()
    }
    
  @objc  func hideEysan (){
        for eysan in eysanArray {
            eysan.isHidden = true
        }
      let random = Int( arc4random_uniform(UInt32(eysanArray.count - 1)))
        eysanArray[random].isHidden = false
    }

    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown (){
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for eysan in eysanArray {
                eysan.isHidden = true
            }
            
            //Highscore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            
            
            //Alert
            let alert = UIAlertController(title: "Süren Doldu", message: "Tekrar Oynamak İster misin?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Tekrar Oyna", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideEysan), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
}

