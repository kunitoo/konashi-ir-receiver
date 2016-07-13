//
//  ViewController.swift
//  konashi-ir-receiver
//
//  Created by ItoKunihiko on 2016/07/12.
//  Copyright © 2016年 ItoKunihiko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Konashi.shared().readyHandler = {() -> Void in
            Konashi.pinMode(KonashiDigitalIOPin.LED2, mode: KonashiPinMode.Output)
            Konashi.digitalWrite(KonashiDigitalIOPin.LED2, value: KonashiLevel.High)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func findKonashi(sender: UIButton) {
        Konashi.find()
    }
    @IBAction func led2On(sender: UIButton) {
        Konashi.digitalWrite(KonashiDigitalIOPin.LED2, value: KonashiLevel.High)
    }
    @IBAction func led2Of(sender: UIButton) {
        Konashi.digitalWrite(KonashiDigitalIOPin.LED2, value: KonashiLevel.Low)
    }
}

