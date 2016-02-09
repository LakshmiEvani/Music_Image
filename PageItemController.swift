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
    var playbackTimer:NSTimer?
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.view.backgroundColor = UIColor.blackColor()
        contentImageView!.image = UIImage(named: imageName)
        
        if let filePathFromSongsList = NSBundle.mainBundle().URLForResource (fileNames[itemIndex], withExtension: "mp3") {
            
            
            audioPlayer = try! AVAudioPlayer(contentsOfURL: filePathFromSongsList)
            audioPlayer.enableRate = true
            
        } else {
            
            print("Filepath is empty")
        }
        
        
        audioPlayer?.play()
        
        volumeControl?.continuous = true
        
        self.playbackTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateProgress"), userInfo: nil, repeats: true)
        

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if ((self.audioPlayer?.playing) != nil) {
            self.audioPlayer!.pause()
            self.playbackTimer?.invalidate()
        }
    }
    
    
    @IBAction func actionVolumeControl(sender: UISlider) {
        
        // if the track was playing store true, so we can restart playing after changing the track position
        self.playbackTimer?.invalidate()
        self.playbackTimer = nil;
        var wasPlaying : Bool = false
        if self.audioPlayer.playing  {
            audioPlayer.pause()
            wasPlaying = true
        }
        audioPlayer.currentTime = NSTimeInterval(round(sender.value))
        updateProgress()
        //starts playing track again it it had been playing
        if (wasPlaying == true) {
            audioPlayer.play()
            self.playbackTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateProgress"), userInfo: nil, repeats: true)
            wasPlaying = false
        }

        
        }
    
    func updateProgress() {
        
        volumeControl?.minimumValue = 0.0
        volumeControl?.maximumValue = Float(audioPlayer.duration)
        volumeControl?.setValue(Float(audioPlayer.currentTime), animated: true)
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
    

    //- AVAudioPlayer delegate method - resets things when track finishe playing
    func PlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        if flag {
            //playButton.selected = false
            isPlaying = false
            audioPlayer.currentTime = 0.0
            updateProgress()
            self.playbackTimer?.invalidate()
            //updater.invalidate()
        }
    }


}
