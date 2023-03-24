//
//  InfoView.swift
//  BullsEye
//
//  Created by zhanybek salgarin on 3/23/23.
//

import UIKit

class InfoView: UIViewController {

    let text: UILabel = {
        let view = UILabel()
        view.text = "This game was created for fun \n Don't take it  to siriouse"
        view.numberOfLines = 0
        view.textColor = .white
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        view.backgroundColor = .systemBlue
        view.addSubview(text)
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}
