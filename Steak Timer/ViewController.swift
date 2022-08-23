//
//  ViewController.swift
//  Steak Timer
//
//  Created by Alexander Shabalin on 18/7/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var countdownText: UILabel!
    
    let steaks: [String: Int] = [
        "Rare": 120,
        "Medium Rare": 180,
        "Medium": 240,
        "Medium Well": 300,
        "Well Done": 360
    ]
    
    var timer = Timer()
    var totalTime: Float = 0
    var secondsPassed: Float = 0
    var player: AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func actionButton(_ sender: UIButton) {
        timer.invalidate()
        let userClicked = sender.titleLabel?.text
        let clicked = userClicked ?? "Default value"
        let result = steaks[clicked]
        
        if result != nil {
            let checkResult = Float(result!)
            totalTime = checkResult
        }
        progressBar.progress = 0.0
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if self.secondsPassed < self.totalTime {
                secondsPassed += 1
                   let persentageProgress = secondsPassed / totalTime
                   
                    
                progressBar.progress = persentageProgress
                   
               } else {
                   Timer.invalidate()
                   self.countdownText.text = "Done!"
                   self.progressBar.progress = 0
                   playSound()

               }
    
        }
        // Эту функции нашел на Stack Overflow - работает, но не совсем понятно как
        func playSound() {
            guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
                return }
            let url = URL(fileURLWithPath: path)

            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }





    }
}
