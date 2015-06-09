//
//  PlaySoundsViewController.swift
//  Voice Changer
//
//  Created by Luke on 2015/06/08.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    
    var audioPlayer:AVAudioPlayer!
    
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    
    var audioFile:AVAudioFile!
    
    
    
    @IBAction func slowSound(sender: AnyObject) {
     
   audioPlayer.stop()
        
    //stop audio to prevent overlapping sound
     
        
   audioPlayer.rate = 0.5
   audioPlayer.currentTime = 0.0
        
        
   //use current time to make sure file is played from the beginning
     
   audioPlayer.play()
   
        
        
        
        
        
    }
    
    
    @IBAction func fastSound(sender: AnyObject) {

        audioPlayer.stop()
        //stop audio to prevent overlapping sound
        
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
    
        //use current time to make sure file is played from the beginning
        audioPlayer.play()
        
        
        
    }
    
    
    
    @IBAction func lowSound(sender: AnyObject) {
        
        
        playAudioWithVariablePitch(-1000)

        
        
    }
    
    
    
    @IBAction func highSound(sender: AnyObject) {
        
        
        playAudioWithVariablePitch(1000)

       
        
        
        
    }
    
 
    
    
    
    
    @IBAction func reverbButton(sender: AnyObject) {
        audioEngineSetup()
        
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        
        var reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(AVAudioUnitReverbPreset.LargeHall2)
        reverb.wetDryMix = 75
        
        
        audioEngine.attachNode(reverb)


        audioEngine.connect(audioPlayerNode, to: reverb, format: nil)
        audioEngine.connect(reverb, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
        
    }
    

    
    
    @IBAction func distortionButton(sender: AnyObject) {
        
        
        audioEngineSetup()
        
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        
        var distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(AVAudioUnitDistortionPreset.MultiEverythingIsBroken)
        distortion.wetDryMix = 25
        
        
        audioEngine.attachNode(distortion)
        
        
        audioEngine.connect(audioPlayerNode, to: distortion, format: nil)
        audioEngine.connect(distortion, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
        
    }
    
    
    
    
  
    
    func playAudioWithVariablePitch(pitch: Float){
        
        //Function that is used to create pitch effects.
        
        audioEngineSetup()

        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    
    
    @IBAction func stopSound(sender: AnyObject) {
        
        audioPlayer.stop()

        
        
        
    }
    
    
    
    func audioEngineSetup() {
        
        //Sets up the audio engine ready to use for sound effects
        
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)

        
        
    }
    
    
    override func viewDidLoad() {
        
        
        
        
        audioPlayer = AVAudioPlayer(contentsOfURL:receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        super.viewDidLoad()
        
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

 

}
