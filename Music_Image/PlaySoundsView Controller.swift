//
//  PlaySoundsView Controller.swift
//  Music_Image
//
//  Created by Souji on 2/1/16.
//  Copyright © 2016 Souji. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsView_Controller: UIViewController {
    
      var audioPlayer:AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if let filePath = NSBundle.mainBundle().URLForResource ("ultimate_kenny_g (17)", withExtension: "mp3") {
            
            audioPlayer = try! AVAudioPlayer(contentsOfURL: filePath)
            audioPlayer.enableRate = true
            
        } else {
            
            print("Filepath is empty")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
