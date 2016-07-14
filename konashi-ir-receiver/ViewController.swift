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
    @IBOutlet weak var cn3text: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Konashi.shared().readyHandler = {() -> Void in
            Konashi.pinMode(KonashiDigitalIOPin.LED2, mode: KonashiPinMode.Output)
            Konashi.digitalWrite(KonashiDigitalIOPin.LED2, value: KonashiLevel.High)
            Konashi.pinMode(KonashiDigitalIOPin.DigitalIO2, mode: KonashiPinMode.Input)
            Konashi.uartMode(KonashiUartMode.Enable, baudrate: KonashiUartBaudrate.Rate9K6)
        }
        Konashi.shared().digitalInputDidChangeValueHandler = {(pin, value) -> Void in
            print("handler: \(value)")
        }
        Konashi.shared().uartRxCompleteHandler = {(data) -> Void in
            print(data.description, ":", data.length)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func findKonashi(sender: UIButton) {
        Konashi.find()
    }
    @IBAction func disconnect(sender: UIButton) {
        Konashi.disconnect()
    }
    @IBAction func led2On(sender: UIButton) {
        Konashi.digitalWrite(KonashiDigitalIOPin.LED2, value: KonashiLevel.High)
    }
    @IBAction func led2Of(sender: UIButton) {
        Konashi.digitalWrite(KonashiDigitalIOPin.LED2, value: KonashiLevel.Low)
    }

    @IBAction func cn3Read(sender: UIButton) {
        let input = Konashi.digitalRead(KonashiDigitalIOPin.DigitalIO2)
        print(input.rawValue)
        cn3text.text = "\(input.rawValue)"

    }

    func readIR() {
        print("\(NSDate())")
        let input = Konashi.digitalRead(KonashiDigitalIOPin.DigitalIO2)
        print(input.rawValue)
    }
}

