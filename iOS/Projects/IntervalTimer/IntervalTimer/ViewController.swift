//
//  ViewController.swift
//  IntervalTimer
//
//  Created by David Hakanson on 7/26/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {

    enum InfoViewType {
        case intervalTime
        case breakTime
    }
    
    var timerConfig: TimerConfig = TimerConfig(intervalTime: 0, breakTime: 0, sets: 0)
    var intervalRunning = false
    var editingInfoView: InfoViewType?
    var timer: Timer = Timer()
    var intervalTime: TimeInterval = 0
    var breakTime: TimeInterval = 0
    var sets: Int = 0
    var player: AVAudioPlayer?
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var intervalInfo: InfoView!
    @IBOutlet weak var breakInfo: InfoView!
    @IBOutlet weak var setInfo: InfoView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var savedConfigurationsTableView: SavedConfigurationsTableView!
    @IBOutlet weak var intervalPickerView: IntervalPickerView!
    @IBOutlet weak var setPickerView: SetPickerView!
    
    @IBAction func clearInterval(_ sender: Any) {
        self.timer.invalidate()
        self.timerConfig = TimerConfig(intervalTime: 0, breakTime: 0, sets: 0)
        self.update()
    }
    
    @IBAction func stopInterval(_ sender: Any) {
        self.intervalRunning = !self.intervalRunning
        
        if (self.intervalRunning) {
            self.stopButton.backgroundColor = ApplicationColors.red
            self.stopButton.setTitle("Stop", for: .normal)
            self.startInterval()
        } else {
            self.stopButton.backgroundColor = ApplicationColors.green
            self.stopButton.setTitle("Start", for: .normal)
            self.timer.invalidate()
        }
    }
    
    @IBAction func saveConfiguration(_ sender: Any) {
        do {
            try self.timerConfig.save()
            self.savedConfigurationsTableView.add(timerConfig: self.timerConfig, reload: true)
        } catch let error as NSError {
            // TODO: show alert
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupInfoContainer()
        self.setupInfoViews()
        self.setupButtons()
        self.setupPickers()
        
        self.savedConfigurationsTableView.configurationSelected = self.configurationSelected(configuration:)
    }
    
    func setupInfoContainer() {
        self.infoContainer.layer.borderColor = ApplicationColors.grey2.cgColor
        self.infoContainer.layer.borderWidth = 1
    }
    
    func setupInfoViews() {
        self.intervalInfo.setTitle("Interval")
        self.breakInfo.setTitle("Break")
        self.setInfo.setTitle("Sets")
        
        self.intervalInfo.onTap = { sender in
            self.intervalPickerView.show()
            self.editingInfoView = .intervalTime
        }
        
        self.breakInfo.onTap = { sender in
            self.intervalPickerView.show()
            self.editingInfoView = .breakTime
        }
        
        self.setInfo.onTap = { sender in
            self.setPickerView.show()
        }
        
        self.update()
    }
    
    func setupButtons() {
        self.clearButton.layer.cornerRadius = self.clearButton.bounds.size.width / 2
        self.clearButton.layer.masksToBounds = true
        
        self.stopButton.layer.cornerRadius = self.stopButton.bounds.size.width / 2
        self.stopButton.layer.masksToBounds = true
    }
    
    func configurationSelected(configuration: TimerConfig) {
        self.timerConfig = configuration
        self.update()
    }

    func setupPickers() {
        self.intervalPickerView.delegate = self
        self.setPickerView.delegate = self
    }
    
    func startInterval() {
        let intervalTime = self.intervalTime / 100
        
        self.timer = Timer.scheduledTimer(withTimeInterval: intervalTime, repeats: true) { _ in
            self.intervalTime -= intervalTime
            
            self.timerLabel.text = "\(Double(Int(self.intervalTime * 10)) / 10)"
            
            if self.intervalTime <= 0 {
                self.timerLabel.text = "0.0"
                self.timer.invalidate()
                self.playSound(named: "interval-ending")
                self.startBreak()
            }
        }
        
        self.timer.fire()
    }
    
    func startBreak() {
        let breakTime = self.breakTime / 100
        var needsPlay = true
        
        if self.sets == 1 {
            self.playSound(named: "done")
            self.update()
        } else {
            self.timer = Timer.scheduledTimer(withTimeInterval: breakTime, repeats: true) { _ in
                self.breakTime -= breakTime
                
                self.timerLabel.text = "\(Double(Int(self.breakTime * 10)) / 10)"
                
                if self.breakTime <= 3.0 && needsPlay {
                    self.playSound(named: "break-ending")
                    needsPlay = false
                }
                
                if self.breakTime <= 0 {
                    self.timerLabel.text = "0.0"
                    self.timer.invalidate()
                    self.completeSet()
                }
            }
            
            self.timer.fire()
        }
    }
    
    func completeSet() {
        self.sets -= 1
        self.intervalTime = TimeInterval(self.timerConfig.intervalTime)
        self.breakTime = TimeInterval(self.timerConfig.breakTime)
        startInterval()
    }
    
    func update() {
        self.intervalRunning = false
        self.intervalInfo.setValue(seconds: self.timerConfig.intervalTime)
        self.breakInfo.setValue(seconds: self.timerConfig.breakTime)
        self.setInfo.setValue(text: "\(self.timerConfig.sets)")
        
        self.timerLabel.text = "\(self.timerConfig.intervalTime)"
        self.intervalTime = TimeInterval(self.timerConfig.intervalTime)
        self.breakTime = TimeInterval(self.timerConfig.breakTime)
        self.sets = self.timerConfig.sets
        
        if (self.timerConfig.intervalTime != 0 && self.timerConfig.sets != 0) {
            self.stopButton.setTitle("Start", for: .normal)
            self.stopButton.backgroundColor = ApplicationColors.green
            self.stopButton.isEnabled = true
        } else {
            self.stopButton.setTitle("Start", for: .normal)
            self.stopButton.backgroundColor = ApplicationColors.grey2
            self.stopButton.isEnabled = false
        }
    }
    
    func playSound(named: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

extension ViewController: IntervalPickerViewDelegate {
    
    func intervalPickingCanceled() {
        print("interval picking canceled")
    }
    
    func intervalSelected(minutes: Int, seconds: Int) {
        guard let infoViewType = self.editingInfoView else { return }
        
        switch infoViewType {
        case .intervalTime:
            self.timerConfig.intervalTime = minutes * 60 + seconds
        case .breakTime:
            self.timerConfig.breakTime = minutes * 60 + seconds
        }
        
        self.update()
    }
    
}

extension ViewController: SetPickerViewDelegate {

    func setPickingCanceled() {
        print("set picking canceled")
    }
    
    func setsSelected(_ sets: Int) {
        self.timerConfig.sets = sets
        self.update()
    }
    
}
