//
//  IllnessCell.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

import UIKit

class IllnessCell: UITableViewCell {

    @IBOutlet weak var illnessNameLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 5
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }

    func set(illness: IllnessItem?) {
        illnessNameLabel.text = unwrapped(illness?.name, with: "")
    }
}
