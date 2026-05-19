//
//  CaptchaModel.swift
//  Captcha
//
//  Created by Pothapragada, Krishna N on 3/24/26.
//

import Foundation



class CaptchaModel: ObservableObject {
    @Published var imageOptions: [String] = []
    @Published var AudioOptions: [String] = []
    private var ImageNames: [String] = []
    @Published var correctImage = ""
    
    private var AudioNames: [String] = []
    @Published var correctAudio = ""
    
    @Published var attempts = 0
    
    @Published var AudioFile = ""
    @Published var hasWon = true
    
    
    func generateVisualCaptcha() {
        let shuffledOptions = ImageNames.shuffled().prefix(4)
        imageOptions = Array(shuffledOptions)
        let chosen = imageOptions.randomElement() ?? ""
        correctImage = chosen.replacingOccurrences(of: ".png", with: "")
    }
    
    func loadAssets() {
        ImageNames.removeAll()
        AudioNames.removeAll()
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png"){
                ImageNames.append(item)
            }
            else if item.hasSuffix(".wav"){
                AudioNames.append(item)
            }
        }
    }
    
    
    func checkAnswer(selected: String) -> Bool {
        let cleanselected = selected.replacingOccurrences(of: ".png", with: "")
        
        if cleanselected == correctImage {
            attempts = 0
            return true
        } else {
            attempts += 1
            return false
        }
    }
    
    func checkAnswerAudio(selected: String) -> Bool {
        var cleanselected = selected.replacingOccurrences(of: ".wav", with: "")
        cleanselected = cleanselected.split(separator: "_").last.map(String.init) ?? cleanselected
        if cleanselected == correctAudio {
            attempts = 0
            return true
        } else {
            attempts += 1
            return false
        }
    }
    
    func generateAudioCaptcha() {
        let selected = AudioNames.shuffled().prefix(4)
        AudioOptions = Array(selected)
        let chosen = AudioOptions.randomElement() ?? ""
        correctAudio = chosen.replacingOccurrences(of: ".wav", with: "")
        AudioFile = correctAudio
        correctAudio = correctAudio.split(separator: "_").last.map(String.init) ?? correctAudio
    }
    
    func resetAttempts() {
        attempts = 0
    }
    
    func theyWon(){
        self.hasWon=true
    }
    
}
