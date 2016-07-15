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
            Konashi.uartMode(KonashiUartMode.Enable, baudrate: KonashiUartBaudrate.Rate9K6)
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

    func readIR() {
    }
}

