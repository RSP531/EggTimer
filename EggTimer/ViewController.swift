//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 5]
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progressBar: UIProgressView!

    @IBOutlet weak var titleLabel: UILabel!
    
    var secondsPassed = 0
    var cookTime = 0;
    
    var timer = Timer()

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        
        let result = eggTimes[hardness]!
        
        cookTime = eggTimes[hardness]!
        secondsPassed = 0
        titleLabel.text = hardness
        progressBar.progress = 0

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateCounter() {

        //example functionality
        if secondsPassed < cookTime {
            let percentageProgress = Float(secondsPassed) / Float(cookTime)
            print(percentageProgress)
            progressBar.progress = Float(percentageProgress)
            secondsPassed += 1
        } else {
            progressBar.progress = 1
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
    }
}
