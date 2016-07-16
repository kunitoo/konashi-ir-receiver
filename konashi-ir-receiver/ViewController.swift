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

    @IBOutlet weak var textView: UITextView!
    var irData: [NSData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Konashi.shared().readyHandler = {() -> Void in
            Konashi.uartMode(KonashiUartMode.Enable, baudrate: KonashiUartBaudrate.Rate9K6)
        }

        Konashi.shared().uartRxCompleteHandler = {(data) -> Void in
            let desc = data.description
            if(desc == "<fe>" || desc == "<fc>" || desc == "<f0>" || desc == "<f8>") {
                return
            }
            print(data.description, ":", data.length)
            self.readIR(data)
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

    @IBAction func sendData(sender: UIButton) {
        var index: Int = 781
        let nsdata = NSData(bytes: &index, length: sizeof(Int))
        Konashi.uartWriteData(nsdata)
    }

    @IBAction func showData(sender: UIButton) {
        let str = irData.map({(data) -> String in
            var buffer = [UInt8](count: data.length, repeatedValue: 0x00)
            data.getBytes(&buffer, length: data.length)
            return "\(buffer)"
        }).joinWithSeparator(",")
        textView.insertText(str)
        irData.removeAll()
    }
    @IBAction func clearView(sender: UIButton) {
        self.textView.text = ""
    }
    func readIR(data: NSData) {
        self.irData.append(data)
    }
}

