//
//  TestViewController.swift
//  BoxTime
//
//  Created by 金澤武士 on 2020/04/13.
//  Copyright © 2020 tk. All rights reserved.
//

import UIKit
import Lottie

class TestViewController: UIViewController {

    @IBOutlet weak var testView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
showAnimation()

        // Do any additional setup after loading the view.
    }
    func showAnimation() {
        
            let animationView = AnimationView()
        let animataion = Animation.named("move")
            animationView.frame = CGRect(x: 0 * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            animationView.animation = animataion
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            testView.addSubview(animationView)
        print("OK")
    }
    

}
