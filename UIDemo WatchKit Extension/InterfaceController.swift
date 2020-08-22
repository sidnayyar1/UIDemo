//
//  InterfaceController.swift
//  UIDemo WatchKit Extension
//
//  Created by Sidharth Nayyar on 8/21/20.
//  Copyright © 2020 Sidharth Nayyar. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    var ounces = 16
       var timerRunning = false
    var usingMetric = false
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        updateConfiguration()
        // Configure interface objects here.
    }
    
    @IBOutlet weak var timerButton: WKInterfaceButton!
    @IBOutlet weak var timer: WKInterfaceTimer!
    @IBAction func onTimerButton() {
//        print("ontimebutton")
//        let countdown: TimeInterval = 20
//        let date = Date(timeIntervalSinceNow: countdown)
//        // 2
//        timer.setDate(date)
//        timer.start()
        
        if timerRunning {
            timer.stop()
            timerButton.setTitle("Start Timer")
        } else { // 2
            let time = cookTemp.cookTimeForOunces(ounces)
            timer.setDate(Date(timeIntervalSinceNow: time))
            timer.start()
            timerButton.setTitle("Stop Timer")
            }
            // 3
              timerRunning = !timerRunning
        
    }
     
    func updateConfiguration() {
//      weightLabel.setText("Weight: \(ounces) oz")
//          cookLabel.setText(cookTemp.stringValue)
        
         cookLabel.setText(cookTemp.stringValue)
         var weight = ounces
          var unit = "oz"
          if usingMetric {
            // 2
            let grams = Double(ounces) * 28.3495
            weight = Int(grams)
            unit = "gm"
        }
        // 3
          weightLabel.setText("Weight: \(weight) \(unit)")
    }
    
    @IBOutlet weak var weightLabel: WKInterfaceLabel!
    
    @IBAction func onMinusButton() {
         ounces -= 1
        updateConfiguration()
    }
    
    @IBAction func onPlusButton() {
         ounces += 1
        updateConfiguration()
    }
    
    
    
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    var cookTemp = MeatTemperature.medium
    
    @IBOutlet weak var cookLabel: WKInterfaceLabel!
    
    @IBAction func onTempChange(_ value: Float) {
        
        if let temp = MeatTemperature(rawValue: Int(value)) {
          cookTemp = temp
          updateConfiguration()
        }
    }
    
    @IBAction func onMetricChanged(_ value: Bool) {
        
        usingMetric = value
         updateConfiguration()
    }
    
}
