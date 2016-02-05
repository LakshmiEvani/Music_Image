//
//  PageItemController.swift
//  Music_Image
//
//  Created by Souji on 1/31/16.
//  Copyright © 2016 Souji. All rights reserved.
//

import UIKit

import AVFoundation

import MediaPlayer

class PageItemController: UIViewController, AVAudioPlayerDelegate {
    
    // MARK: - Variables
    var itemIndex: Int = 0
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }
    
    let fileNames = ["ultimate_kenny_g (8)","ultimate_kenny_g (9)","ultimate_kenny_g (10)","ultimate_kenny_g (14)","ultimate_kenny_g (17)"]
    
    
    var audioPlayer:AVAudioPlayer!
    
    var wrapperView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 560))
    
    @IBOutlet var contentImageView: UIImageView?
    
    @IBOutlet weak var volumeControl: UISlider!
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        contentImageView!.image = UIImage(named: imageName)
        
        
        if let filePathFromSongsList = NSBundle.mainBundle().URLForResource (fileNames[itemIndex], withExtension: "mp3") {
            
            
            audioPlayer = try! AVAudioPlayer(contentsOfURL: filePathFromSongsList)
            audioPlayer.enableRate = true
            
        } else {
            
            print("Filepath is empty")
        }
        
        volumeControl?.maximumValue = Float((audioPlayer?.duration)!)
        
           audioPlayer?.play()

    }
    
    
    
    @IBAction func actionVolumeControl(sender: UISlider) {
        
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0.0
        audioPlayer?.play()
        
        self.view.addSubview(wrapperView)
        wrapperView.hidden = false
        
        
        let volumeView = MPVolumeView(frame: wrapperView.bounds)
        wrapperView.addSubview(volumeView)
        
        
        }
    
    @IBOutlet weak var Stop: UIButton!
      var isPlaying = false
    
    @IBAction func AudioStop(sender: UIButton) {
            
            audioPlayer?.stop()
            wrapperView.hidden = true
            isPlaying = false
    }
    
    
    @IBOutlet weak var Pause: UIButton!
    
   
    
    @IBAction func AudioPause(sender: UIButton) {
        

        if isPlaying {
            
            audioPlayer?.pause()
            isPlaying = false
        } else {
            audioPlayer?.play()
            isPlaying = true
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
