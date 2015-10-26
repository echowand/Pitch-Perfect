//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Guanqun Mao on 10/20/15.
//  Copyright © 2015 Guanqun Mao. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var recordedAudio: RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL: recordedAudio.filePathUrl)
            audioPlayer.enableRate = true
        }catch let error as NSError{
            print("Failed to play audio: " + error.localizedDescription)
        }
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: recordedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // slow sound
    @IBAction func onPlaySound(sender: UIButton) {
        playSound(0.5)
    }

    @IBAction func onFastSound(sender: UIButton) {
        playSound(1.5)
    }
    
    @IBAction func onChipmunkSound(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func onDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playSound(rate: Float){
        stopAudio()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    func stopAudio(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    @IBAction func onStopSound(sender: UIButton) {
        stopAudio()
    }

}
