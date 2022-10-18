//
//  ViewController.swift
//  Workout timer
//
//  Created by Стас Бойко on 23.09.2022.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var addMoreButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var newSetButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var exerciseNameTextField: UITextField?
    var exerciseTimeTextField: UITextField?
    var restTimeTextField: UITextField?
    
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newSetButton.layer.cornerRadius = 15
        startButton.layer.cornerRadius = 20
        addMoreButton.layer.cornerRadius = 20
        addMoreButton.isHidden = true
        startButton.isHidden = true
        tableView.isHidden = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "WorkoutTableViewCell", bundle: nil), forCellReuseIdentifier: "workout")
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "header")
    }
    
    @IBAction func createNewSetPressed(_ sender: Any) {
        addExercise()
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "start") as? StartViewController else { return }
        vc.startScreen = self
        vc.loadViewIfNeeded()
        vc.startTimer()
        present(vc, animated: true)
        
    }
    
    @IBAction func addMoreButtonPressed(_ sender: Any) {
        addExercise()
    }
    
    private func addExercise() {
        
        alert = UIAlertController(title: "Add new set", message: nil, preferredStyle: .alert)
        
        alert.addTextField {
            (exerciseName) -> Void in
            self.exerciseNameTextField = exerciseName
            self.exerciseNameTextField?.placeholder = "Enter exercise name"
            self.exerciseNameTextField?.keyboardType = .default
            self.exerciseNameTextField?.addTarget(self, action: #selector(self.alertTextFieldDidChanged(_:)), for: .editingChanged)
        }
        
        alert.addTextField {
            (exerciseTime) -> Void in
            self.exerciseTimeTextField = exerciseTime
            self.exerciseTimeTextField?.placeholder = "Enter time for exercise"
            self.exerciseTimeTextField?.keyboardType = .numberPad
            self.exerciseTimeTextField?.addTarget(self, action: #selector(self.alertTextFieldDidChanged(_:)), for: .editingChanged)
        }
        
        alert.addTextField {
            (restTime) -> Void in
            self.restTimeTextField = restTime
            self.restTimeTextField?.placeholder = "Enter time for rest"
            self.restTimeTextField?.keyboardType = .numberPad
            self.restTimeTextField?.addTarget(self, action: #selector(self.alertTextFieldDidChanged(_:)), for: .editingChanged)
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { action in
            
            guard let name = self.exerciseNameTextField?.text, let time = self.exerciseTimeTextField?.text, let rest = self.restTimeTextField?.text else { return }
            
            Workouts.workouts.append(Exercise(name: name, time: time, rest: rest))
            self.newSetButton.isHidden = true
            self.startButton.isHidden = false
            self.addMoreButton.isHidden = false
            self.tableView.reloadData()
            self.tableView.isHidden = false
            
        })
        
        addAction.isEnabled = false
        alert.addAction(addAction)
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        present(alert, animated: true)
    }
    
    @objc func alertTextFieldDidChanged(_ sender: UITextField) {
        if exerciseNameTextField!.text!.isEmpty || exerciseTimeTextField!.text!.isEmpty || restTimeTextField!.text!.isEmpty {
            alert.actions[0].isEnabled = false
        } else {
            alert.actions[0].isEnabled = true
        }
    }
    
    func setupStartScreen() {
        newSetButton.isHidden = false
        tableView.isHidden = true
        addMoreButton.isHidden = true
        startButton.isHidden = true
    }
   
    func checkForExercisesCount() {
        if Workouts.workouts.isEmpty {
            setupStartScreen()
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        Workouts.workouts.remove(at: indexPath.row)
        checkForExercisesCount()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: "header") else { return UIView() }
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Workouts.workouts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "workout") as? WorkoutTableViewCell else { return UITableViewCell() }
        
        if !Workouts.workouts.isEmpty {
            cell.addExercise(Workouts.workouts[indexPath.row])
       }
        
        return cell
    }
    
    
}

