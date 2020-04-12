//
//  SettingViewController.swift
//  BoxTime
//
//  Created by 金澤武士 on 2020/04/10.
//  Copyright © 2020 tk. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    //分、秒、ミリ秒の初期化
    var (minutes, seconds, milliseconds) = (3, 0, 0)
    //分、秒、ミリ秒の初期化(IntervalTime用)
    var (minutesforInterval, secondsforInterval) = (0, 60)
    //daticker array
    let setMinuteArray: [Int] = Array(0...60)
    let setSecArray = [0, 10, 20, 30, 40, 50, 60]

    //datepicker for set time
    @IBOutlet weak var settingPickerTime: UIPickerView!
    //datepicker for set intervaltime
    @IBOutlet weak var settingIntervalPickerTime: UIPickerView!

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch pickerView {
        case settingPickerTime:
            return setMinuteArray.count
        case settingIntervalPickerTime:
            return setSecArray.count
        default:
            fatalError()
        }
    }
    // UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == settingPickerTime {
            // 1個目のピッカーの設定
            return String(setMinuteArray[row])
        } else {
            return String(setSecArray[row])
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //User Defaults Instance
        switch pickerView {
        case settingPickerTime:
            let userDefaults = UserDefaults.standard
            userDefaults.set(setMinuteArray[row], forKey: "UDKeyminutes")
        case settingIntervalPickerTime:
            let userDefaults = UserDefaults.standard
            userDefaults.set(setSecArray[row], forKey: "UDKeysecondsforInterval")
        default:
            fatalError()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        //set delegate
        settingPickerTime.delegate = self
        settingPickerTime.dataSource = self

        settingIntervalPickerTime.delegate = self
        settingIntervalPickerTime.dataSource = self

        //User Defaults Instance
        let userDefaults = UserDefaults.standard
        //Get propaty From UD
        if let UDKeyminutes = userDefaults.object(forKey: "UDKeyminutes") {
            minutes = UDKeyminutes as! Int
        } else {
            minutes = 3
        }
        if let UDKeyseconds = userDefaults.object(forKey: "UDKeyseconds") {
            seconds = UDKeyseconds as! Int
        } else {
            seconds = 0
        }
        if let UDKeymilliseconds = userDefaults.object(forKey: "UDKeymilliseconds") {
            minutes = UDKeymilliseconds as! Int
        } else {
            milliseconds = 0
        }

        if let UDKeyminutesforInterval = userDefaults.object(forKey: "UDKeyminutesforInterval") {
            minutesforInterval = UDKeyminutesforInterval as! Int
        } else {
            minutesforInterval = 0
        }

        if let UDKeysecondsforInterval = userDefaults.object(forKey: "UDKeysecondsforInterval") {
            secondsforInterval = UDKeysecondsforInterval as! Int
        } else {
            secondsforInterval = 60
        }

    }

    //変更を反映させるボタン
    @IBAction func setSettingButton(_ sender: Any) {
        //UDに設定値を保存

        //delegate
    }


}
