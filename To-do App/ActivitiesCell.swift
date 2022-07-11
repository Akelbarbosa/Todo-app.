//
//  CategorieCell.swift
//  To-do App
//
//  Created by Akel Barbosa on 6/07/22.
//

import Foundation
import UIKit

class ActivitiesCell: UITableViewCell {
    
    private let activitiesTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setup() {
    
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        contentView.addSubview(activitiesTitle)
        
        NSLayoutConstraint.activate([
            activitiesTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            activitiesTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            activitiesTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
        
        
    }
    
    func configure(activity: Activities ){
        activitiesTitle.text = activity.name
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
