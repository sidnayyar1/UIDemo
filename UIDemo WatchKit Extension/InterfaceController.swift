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
    
    
    @IBOutlet weak var temperaturePicker: WKInterfacePicker!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        var weightItems: [WKPickerItem] = []
        for i in 1...32 {
        // 2
          let item = WKPickerItem()
          item.title = String(i)
          weightItems.append(item)
        }
        // 3
        weightPicker.setItems(weightItems)
        // 4
        weightPicker.setSelectedItemIndex(ounces - 1)
        
        var tempItems: [WKPickerItem] = []
        for i in 1...4 {
        // 2
          let item = WKPickerItem()
          item.contentImage = WKImage(imageName: "temp-\(i)")
          tempItems.append(item)
        }
        // 3
        temperaturePicker.setItems(tempItems)
        // 4
        onTemperatureChanged(0)
        
    }
    @IBAction func onTemperatureChanged(_ value: Int) {
        
        let temp = MeatTemperature(rawValue: value)!
         cookTemp = temp
         temperatureLabel.setText(temp.stringValue)
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
        scroll(to: timer, at: .top, animated: true)
        
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
    @IBAction func onWeightChanged(_ value: Int) {
        
        ounces = value + 1
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
    
    
    @IBOutlet weak var weightPicker: WKInterfacePicker!
    
    @IBOutlet weak var temperatureLabel: WKInterfaceLabel!
    
}
