//
//  ViewController.swift
//  BoxTime
//
//  Created by 金澤武士 on 2020/04/08.
//  Copyright © 2020 tk. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //Timerクラスのインスタンス化
    var timer = Timer()
    //Timerクラスのインスタンス化
    var intervalTimer = Timer()
    //分、秒、ミリ秒の初期化
    var (minutes, seconds, milliseconds) = (0, 10, 0)
    //分、秒、ミリ秒の初期化(IntervalTime用)
    var (minutesforInterval, secondsforInterval) = (0, 3)
    //soundfile
    let soundFile1 = Bundle.main.bundleURL.appendingPathComponent("gong_start.mp3")
    let soundFile2 = Bundle.main.bundleURL.appendingPathComponent("gong_finish.mp3")
    //make PlayerInstance
    var soundPlay = AVAudioPlayer()
    
    //objects
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var millisecTimerLabel: UILabel!
    @IBOutlet weak var intervalTimeLabel: UILabel!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var stopTimeButton: UIButton!
    @IBOutlet weak var resetTimeButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        //タイマー表示設定
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let millisecondsString = "\(milliseconds)"

        //カウントダウン時刻表示
        timerLabel.text = "\(minutesString):\(secondsString):"
        millisecTimerLabel.text = "00"

        //インターバルタイマー表示設定
        
    }

    @IBAction func startTimeButton(_ sender: Any) {
        
        //ゴングの音を鳴らす
        do{
          soundPlay = try AVAudioPlayer(contentsOf: soundFile1) // soundFileを参照
          soundPlay.play()
        }catch{
          print("sound error")
        }
        //設定したタイマーをカウントダウンさせる処理
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.setTimer), userInfo: nil, repeats: true)
        //Startボタン&resetボタンロック
        startTimeButton.isEnabled = false
        resetTimeButton.isEnabled = false

    }

    @IBAction func stopTimeButton(_ sender: Any) {
        //タイマー停止処理
        timer.invalidate()
        intervalTimer.invalidate()
        //startボタン&resetボタンロック解除
        startTimeButton.isEnabled = true
        resetTimeButton.isEnabled = true
    }
    @IBAction func resetTimeButton(_ sender: Any) {
        //タイマーもしくはインターバルタイマーをresetする処理

    }

    //タイマー設定メソッド
    @objc func setTimer() {
          if seconds == 0 && minutes == 0 && milliseconds == 0 {
                   var (minutes, seconds, milliseconds) = (0, 10, 0)
        }
            //var (minutes, seconds, milliseconds) = (0, 10, 0)
        //タイマー実装処理
        //分数設定　秒数が0かつ分数が0でなければ分数から1分マイナスする
        if seconds == 0 && minutes != 0 {
            minutes -= 1
            seconds = 60
        }
        //秒数ミリ秒数が0かつ秒数が0でなければ秒数から1秒マイナスする
        if milliseconds == 0 && seconds != 0 {
            seconds -= 1
            milliseconds = 99
        }
        //ミリ秒数秒数分数がが0であればタイマー終了
        if seconds == 0 && minutes == 0 && milliseconds == 0 {
            timer.invalidate()
            //ゴングの音を鳴らす(終了)
             do{
               soundPlay = try AVAudioPlayer(contentsOf: soundFile2) // soundFileを参照
               soundPlay.play()
             }catch{
               print("sound error")
             }
            //もしインターバルタイマーが設定されていればカウントダウン開始
            //設定したタイマーをカウントダウンさせる処理
                 intervalTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.setIntervalTimer), userInfo: nil, repeats: true)
            setIntervalTimer()
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
        //ミリ秒が0になったら表示を00にする
        if milliseconds == 0 {
            millisecTimerLabel.text = "00"
        }
    }

    //インターバルタイマー設定メソッド
    @objc func setIntervalTimer() {
      
//分数設定　秒数が0かつ分数が0でなければ分数から1分マイナスする
        if secondsforInterval == 0 && minutesforInterval != 0 {
            minutesforInterval -= 1
            secondsforInterval = 60
        }

        //秒数分数がが0であればタイマー終了
        if secondsforInterval == 0 && minutesforInterval == 0 {
            intervalTimer.invalidate()
            //タイマー開始
            //改めてタイマーの値をsetする
            //設定したタイマーをカウントダウンさせる処理
           //timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.setTimer), userInfo: nil, repeats: true)
  
            //setTimer()
            //もしインターバルタイマーが設定されていればカウントダウン開始
        } else {
            secondsforInterval -= 1
            print(secondsforInterval)
        }
        //表示用の　分　秒　ミリ秒
        let minutesforIntervalString = minutesforInterval > 9 ? "\(minutesforInterval)" : "0\(minutesforInterval)"
        let secondsforIntervalString = secondsforInterval > 9 ? "\(secondsforInterval)" : "0\(secondsforInterval)"

        //カウントダウン時刻表示
        
        intervalTimeLabel.text = "\(minutesforIntervalString):\(secondsforIntervalString):"

    }

}

