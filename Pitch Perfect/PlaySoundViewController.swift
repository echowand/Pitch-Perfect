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
            self.audioPlayer.enableRate = true
        }catch{
            print("Error")
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
        self.audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        self.audioPlayer.rate = 0.5
        self.audioPlayer.currentTime = 0
        self.audioPlayer.play()
    }

    @IBAction func onFastSound(sender: UIButton) {
        self.audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        self.audioPlayer.rate = 1.5
        self.audioPlayer.currentTime = 0
        self.audioPlayer.play()
    }
    
    @IBAction func onChipmunkSound(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func onDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
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
        self.audioPlayer.stop()
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
