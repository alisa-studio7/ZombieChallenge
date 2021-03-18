//
//  HospitalCell.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

import UIKit

class HospitalCell: UITableViewCell {

    @IBOutlet weak var hospitalNameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var avgProcessTimeLabel: UILabel!
    @IBOutlet weak var patientsLabel: UILabel!
    @IBOutlet weak var waitingTimeLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 5
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
    
    func set(suggestedHospital: Hospital) {
        hospitalNameLabel.text = suggestedHospital.name
        hospitalNameLabel.adjustsFontSizeToFitWidth = true
        levelLabel.text = "Level: \(unwrapped(suggestedHospital.waitingList.first?.levelOfPain, with: 0))"
        avgProcessTimeLabel.text = "\(unwrapped(suggestedHospital.waitingList.first?.averageProcessTime, with: 0)) mins"
        patientsLabel.text = "\(unwrapped(suggestedHospital.waitingList.first?.patientCount, with: 0))"
        waitingTimeLabel.text = "\(unwrapped(suggestedHospital.waitingList.first?.waitingTime, with: 0)) mins"
    }

}
