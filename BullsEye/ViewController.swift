//
//  ViewController.swift
//  BullsEye
//
//  Created by zhanybek salgarin on 3/20/23.
//

import UIKit

class ViewController: UIViewController {
    
    let step: Float = 10
    var randomBeginningValue: Int {
        let randomInt = Int.random(in: 1...100)
        return randomInt
    }
    var startAndFurtherScores: Int = 0
    
    var numberOfRounds: Int = 0 {
        didSet {
            roundSumLbl.text = String(numberOfRounds)
        }
    }
    
    private var roolsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.text = "Put the Bull's Eye as close as you can to:"
        lbl.textColor = .black
        return lbl
    }()
    
    private var rootScore: UILabel = {
        let score = UILabel()
        score.font = UIFont.boldSystemFont(ofSize: 20)
        score.textColor = .black
        return score
    }()
    
    private var minScore: UILabel = {
        let score = UILabel()
        score.text = "1"
        score.textColor = .black
        score.textAlignment = .center
        return score
    }()
    
    private var maxScore: UILabel = {
        let score = UILabel()
        
        score.text = "100"
        score.textColor = .black
        score.textAlignment = .right
        return score
    }()
    
    private var hitMeButton: UIButton = {
        let score = UIButton()
        score.setTitle("Hit Me!", for: .normal)
        score.setTitleColor(.systemBlue, for: .normal)
        return score
    }()
    
    private var startOverBtn: UIButton = {
        let score = UIButton()
        score.setTitle("Start Over", for: .normal)
        score.setTitleColor(.systemBlue, for: .normal)
        return score
    }()
    
    private var scoreLabel: UILabel = {
        let score = UILabel()
        score.text = "Score:"
        score.textColor = .black
        score.numberOfLines = 0
        return score
    }()
    
    private var scoreSum: UILabel = {
        let score = UILabel()
        score.text = "0"
        score.textColor = .black
        score.numberOfLines = 0
        return score
    }()
    
    private var roundLbl: UILabel = {
        let score = UILabel()
        score.text = "Round"
        score.textColor = .black
        return score
    }()
    
    private var roundSumLbl: UILabel = {
        let score = UILabel()
        score.text = "0"
        score.textColor = .black
        return score
    }()
    
    private var infoButton: UIButton = {
        let score = UIButton(type: .custom)
        score.setImage(UIImage(systemName: "info.circle"), for: .normal)
        score.clipsToBounds = true
        score.imageView?.contentMode = .scaleToFill
        score.contentVerticalAlignment = .fill
        score.contentHorizontalAlignment = .fill
        
        return score
    }()
    
    let slider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        configureUI()
        configure()
        
        
        // Mark: All buttons that configurations when touched
        slider.addTarget(self, action: #selector(sliderButtonPressed), for: .touchUpInside)
        startOverBtn.addTarget(self, action: #selector(startOverPresses), for: .touchUpInside)
        hitMeButton.addTarget(self, action: #selector(hitMeButtonPressed), for: .touchUpInside)
    }
    
    func configureUI() {
        //        [roolsLabel, rootScore, minScore, maxScore, hitMeButton, startOverBtn, scoreLabel, scoreSum, roundLbl, roundSumLbl, infoButton] .forEach { view.addSubview($0) }
        [roolsLabel, rootScore, hitMeButton, slider, minScore, maxScore, scoreLabel, scoreSum, roundLbl, roundSumLbl, startOverBtn, infoButton] .forEach { view.addSubview($0) }
        
        roolsLabel.anchor(top: view.topAnchor,
                          left: view.leftAnchor,
                          right: rootScore.leftAnchor,
                          paddingTop: 150,
                          paddingLeft: 5,
                          height: 50)
        
        rootScore.anchor(top: roolsLabel.topAnchor,
                         left: roolsLabel.rightAnchor,
                         right: view.rightAnchor,
                         paddingLeft: 5,
                         paddingRight: 5,
                         width: 50,
                         height: 50)
        
        slider.anchor(top: roolsLabel.bottomAnchor,
                      left: view.leftAnchor,
                      right: view.rightAnchor,
                      paddingTop: 100,
                      paddingLeft: 10,
                      paddingRight: 10)
        
        hitMeButton.anchor(top: slider.bottomAnchor,
                           left: view.leftAnchor,
                           right: view.rightAnchor,
                           paddingTop: 100,
                           width: 100,
                           height: 50)
        
        minScore.anchor(left: slider.leftAnchor,
                        bottom: slider.topAnchor,
                        paddingBottom: 10,
                        width: 25,
                        height: 25)
        
        maxScore.anchor(top: nil,
                        left: nil,
                        bottom: slider.topAnchor,
                        right: slider.rightAnchor,
                        paddingBottom: 10,
                        width: 55,
                        height: 25)
        
        scoreLabel.anchor(top: hitMeButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: scoreSum.leftAnchor, paddingTop: 100, paddingLeft: view.bounds.width/3, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
        scoreSum.anchor(top: scoreLabel.topAnchor, left: scoreLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        
        roundLbl.anchor(top: scoreLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: roundSumLbl.leftAnchor, paddingTop: 20, paddingLeft: view.bounds.width/3, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        roundSumLbl.anchor(top: scoreLabel.bottomAnchor, left: roundLbl.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        startOverBtn.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 50, paddingBottom: 50, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        infoButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 50, paddingRight: 50, width: 34, height: 34, enableInsets: true)
    }
    
    func configure() {
        scoreSum.text = "\(startAndFurtherScores)"
        rootScore.text = "\(randomBeginningValue)"
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.tintColor = UIColor.green
    }
    
    @objc func sliderButtonPressed(_ sender: UISlider) {
        //        print(sender)
    }
    
    @objc func startOverPresses() {
        scoreSum.text = String("0")
        roundSumLbl.text = String("0")
        slider.value = 0
        rootScore.text = "\(randomBeginningValue)"
    }
    
    @objc func hitMeButtonPressed(_ sender: UISlider) {
        
        let hitResult = slider.value
        guard let target = Float(rootScore.text ?? "0") else { return }
        var difference = target - hitResult
        var scoreGained = 0
        print(difference)
        if difference < 0 {
            difference *= -1
        }
        print(difference)
        if difference <= 2 {
            scoreGained = 3
            startAndFurtherScores = startAndFurtherScores + scoreGained
            scoreSum.text = "\(startAndFurtherScores)"
        }
        else if difference <= 5 {
            scoreGained = 2
            startAndFurtherScores = startAndFurtherScores + scoreGained
            scoreSum.text = "\(startAndFurtherScores)"
        } else if difference <= 10 {
            scoreGained = 1
            startAndFurtherScores = startAndFurtherScores + scoreGained
            scoreSum.text = "\(startAndFurtherScores)"
        } else {
            scoreGained = 0
            startAndFurtherScores = startAndFurtherScores + scoreGained
            scoreSum.text = "\(startAndFurtherScores)"
        }
        
        let alertController = UIAlertController(title: "Your result", message: "You've got \(scoreGained) ", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Continue", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true) {
            self.startNewRound()
        }
    }
    
    func startNewRound() {
        numberOfRounds += 1
        slider.value = 0
        rootScore.text = String(randomBeginningValue)
    }
}

