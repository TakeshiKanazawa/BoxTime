//
//  ViewController.swift
//  BoxTime
//
//  Created by 金澤武士 on 2020/04/08.
//  Copyright © 2020 tk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Timerクラスのインスタンス化
    var timer = Timer()
    //分、秒、ミリ秒の初期化
    var (minutes, seconds, milliseconds) = (3, 0, 0)

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var millisecTimerLabel: UILabel!
    @IBOutlet weak var intervalTimeLabel: UILabel!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var stopTimeButton: UIButton!
    @IBOutlet weak var resetTimeButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startTimeButton(_ sender: Any) {
        //設定したタイマーをカウントダウンさせる処理
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.keepTimer), userInfo: nil, repeats: true)
        //Startボタン&resetボタンロック
        startTimeButton.isEnabled = false
        resetTimeButton.isEnabled = false

    }

    @IBAction func stopTimeButton(_ sender: Any) {
        //タイマー停止処理
        timer.invalidate()
        //startボタン&resetボタンロック解除
        startTimeButton.isEnabled = true
        resetTimeButton.isEnabled = true
    }
    @IBAction func resetTimeButton(_ sender: Any) {
        //タイマーもしくはインターバルタイマーをresetする処理

    }
    @objc func keepTimer() {
        //タイマー実装処理
        //分数 秒数が0かつ分数が0でなければ分数から1分マイナスする
        if seconds == 0 && minutes != 0 {
            minutes -= 1
            seconds = 60
        }

        //秒数 ミリ秒数が0かつ秒数が0でなければ秒数から1秒マイナスする
        if milliseconds == 0 && seconds != 0 {
            seconds -= 1
            milliseconds = 99
        }

        //ミリ秒数秒数分数がが0であればタイマー終了
        if seconds == 0 && minutes == 0 && milliseconds == 0 {
            timer.invalidate()
        } else {
            milliseconds -= 1
        }
    

//表示用の　分　秒　ミリ秒
    let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
    let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
    let millisecondsString = "\(milliseconds)"
//カウントダウン時刻表示
    timerLabel.text = "\(minutesString):\(secondsString):"
        millisecTimerLabel.text = "\(millisecondsString)"


}


}

