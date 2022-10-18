//
//  StartViewController.swift
//  Workout timer
//
//  Created by Стас Бойко on 23.09.2022.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var startScreen: ViewController?
    
    var timer = Timer()
    var secForExercise = Int()
    var secForRest = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func startTimer() {
    
            nameLabel.text = Workouts.workouts[0].name
            timeLabel.text = Workouts.workouts[0].time
            secForExercise = Int(Workouts.workouts[0].time) ?? 0
            secForRest = Int(Workouts.workouts[0].rest) ?? 0
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)
    }
    
    
    
    @objc func timerCount() {
        
        if secForExercise > 0 {
            secForExercise -= 1
            timeLabel.text = String(secForExercise)
        } else if secForExercise == 0 {
            nameLabel.text = "Rest"
            timeLabel.text = String(secForRest)
            secForRest -= 1
            if secForRest < 0 {
                Workouts.workouts.removeFirst()
                timer.invalidate()
                
                if !Workouts.workouts.isEmpty {
                    startTimer()
                } else {
                    showFinishedAlert()
                }
            }
        }
    }
    
    
    private func showFinishedAlert() {
        let alert = UIAlertController(title: "You did it!", message: "\n👍💪", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yesss", style: .cancel, handler: { action in
            self.startScreen?.setupStartScreen()
            self.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }

}
