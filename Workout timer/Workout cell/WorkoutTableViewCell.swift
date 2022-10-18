//
//  WorkoutTableViewCell.swift
//  Workout timer
//
//  Created by Стас Бойко on 23.09.2022.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var restTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addExercise(_ ex: Exercise) {
        nameLabel.text = ex.name
        timeLabel.text = ex.time
        restTimeLabel.text = ex.rest
    }
    
}
