//
//  ViewController.swift
//  FaceView
//
//  Created by Сервис on 19/03/2017.
//  Copyright © 2017 Kremlev. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
   
    @IBOutlet weak var faceView: FaceView!
    
    @IBOutlet weak var slider: UISlider!
    @IBAction func sliderMove(_ sender: UISlider) {
    faceView.smileRation = CGFloat(slider.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

