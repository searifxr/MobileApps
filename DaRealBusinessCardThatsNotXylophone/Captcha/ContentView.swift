//
//  ContentView.swift
//  Captcha
//
//  Created by Pothapragada, Krishna N on 3/24/26.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var Captcha: CaptchaModel = CaptchaModel()
    
    @State var imageOptions: [String] = []
    @State var AudioOptions: [String] = []
    @State var Started: Bool = false
    @State var imageSectionPassed: Bool = false
    @State var audioSectionPassed: Bool = false
    
    @State var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        VStack {
            if !Started && Captcha.attempts == 0 {
                Image("son")
                Button(){
                    GerrrrroooobWithsitImagery()
                } label: {
                    Text("تر هغه چې موږ هغه بدمرغه ځمکې ته ورسیږو.")
                }
            }
            else{
                if !imageSectionPassed && Captcha.attempts < 4{
                    VStack{
                        Text("للتأكد مما إذا كنت روبوتاً أم لا، يرجى التحقق من أنك روبوت")
                            .font(.title2)
                        Text(Captcha.correctImage)
                            .font(.title2)
                            .fontWeight(.black)
                    }
                    VStack{
                        ForEach(Array(stride(from: 0, to: Captcha.imageOptions.count, by: 2)), id: \.self){ index in
                            HStack{
                                Button(action:{
                                    checkAnswer(Captcha.imageOptions[index])
                                }){
                                    ImageHelper(Captcha.imageOptions[index])
                                }
                                Button(action: {
                                    checkAnswer(Captcha.imageOptions[index+1])
                                }){
                                    if index + 1 < Captcha.imageOptions.count{
                                        ImageHelper(Captcha.imageOptions[index+1])
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if !audioSectionPassed && imageSectionPassed && Captcha.attempts < 4 {
                Text("別再顧左右而言他了，你最好老實回答這個問 別磨蹭了，夥計，你最好把問題答了 別磨蹭了，夥計，你最好把問題答了 別再拖延了，老兄——你最好回答這個問題你最好回答這個問題。別再拖延了，老兄——你真的必須回答這個問 如果你的女朋友很漂亮，那你的女朋友就會很漂亮。Glory to CCP!!🇨🇳🈯️⚧")
                    .font(.title3)
                
                Button(action: {
                    PlayAudio()
                }){Label("", systemImage: "play.fill")}
                
                Spacer()
                
                VStack{
                    ForEach(Array(stride(from: 0, to: Captcha.AudioOptions.count, by: 2)), id: \.self){ index in
                        HStack{
                            Button(action:{
                                checkAnswer(Captcha.AudioOptions[index])
                            }){
                                AudioNameCleaner(Captcha.AudioOptions[index])
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(.black)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                checkAnswer(Captcha.AudioOptions[index+1])
                            }){
                                if index + 1 < Captcha.AudioOptions.count{
                                    AudioNameCleaner(Captcha.AudioOptions[index+1])
                                        .font(.title3)
                                        .fontWeight(.black)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                    }
                }
                
            }
            else if imageSectionPassed && audioSectionPassed && Captcha.attempts < 4 {
                
                Text("Bonjour fellow Human")
                Spacer()
                Text("niche Human Content")
                    .font(.system(size: 100))
                    .foregroundStyle(.pink)
                Color()
                Button("You don't wanna know") {
                    reset()
                }
            }
            else if Captcha.attempts == 4 && !imageSectionPassed && !audioSectionPassed || imageSectionPassed && !audioSectionPassed{
                Text("")
                Spacer()
                Text("ⴽⴻⵞⵞ ⴷ ⴰⵕⵓⴱⵓ; ⵓⵔ ⵜⴻⵣⵎⵉⵔⴻⴹ ⴰⵔⴰ ⴰⴷ ⵜⴽⴻⵛⵎⴻⴹ ⵙ ⴰⴳⴱⵓⵔ ⵏ ⵓⵎⴷⴰⵏ ⴽⴰⵏ—ⵢⴻⵜⵜⵡⴰⵙⴱⴻⴷⴷⴻⵏ ⵉ ⵢⵉⵃⵔⵉⵛⴻⵏ ⵏ ⵜⵏⵉⵚⵍⵉⵜ ⵉⴳⴻⵔⵔⵣⴻⵏ—ⴰⵢ ⵢⴻⵍⵍⴰⵏ ⵎⴰ ⵓⵍⴰⵛ ⴰⴷ ⴽⵉⴷⵢⴻⴼⴽ. ⵏⴻⴽⴽ ⵜⵜⴹⴻⴳⴳⵉⵔⴻⵖⴰⴽⴷ ⵍⵃⵉⵔⴼⴰ ⵜⵓⵔⴰ ⴽⴰⵏ! 你是機器人；你無法存取那些特定且層級受限的內容──因為那些內容原本就不適用於你。此刻，我真為你感到高興！אתה רובוט; אינך יכול לגשת לתוכן הספציפי והמוגבל הזה - כי התוכן הזה מעולם לא נועד עבורך מלכתחילה. כרגע, אני באמת שמח בשבילך! त्वं रोबोट् असि; भवन्तः तां विशिष्टां, प्रतिबन्धितस्तरीयं सामग्रीं प्राप्तुं न शक्नुवन्ति-यतोहि सा सामग्री प्रथमतया भवतः कृते कदापि न अभिप्रेता आसीत् । अधुना, अहं भवतः कृते यथार्थतया प्रसन्नः अनुभवामि! თქვენ რობოტი ხართ; თქვენ არ გაქვთ წვდომა ამ კონკრეტულ, შეზღუდული დონის კონტენტზე, რადგან ეს კონტენტი თავიდანვე არასდროს ყოფილა თქვენთვის განკუთვნილი. ახლა კი, მე ნამდვილად მიხარია თქვენთვის! تون هڪ روبوٽ آهين؛ تون ان مخصوص، محدود سطح جي مواد تائين رسائي نٿو ڪري سگهين - ڇاڪاڻ ته اهو مواد پهرين ڪڏهن به توهان لاءِ نه هو. هاڻي، مان واقعي توهان لاءِ خوش آهيان! Yïn ee raan ë rïŋ; yïn acïï lëu ba kë tɔ̈u thïn yök, kë cï gël-tök—rin kën kën akëc kan looi tënë yïn në thɛɛr tueŋ. Në yemɛɛn, ɣɛn acï puɔ̈u miɛt apɛi tënë yïïn!")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
        }
        
        .padding()
    }
    
    func AudioNameCleaner(_ audioName: String) -> some View{
        return Text(audioName.split(separator: "_").last.map(String.init) ?? audioName)
    }
    
    
    func PlayAudio() {
        guard let path = Bundle.main.path(forResource: Captcha.AudioFile, ofType: "wav") else {
            print("Audio file not found")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            audioPlayer?.prepareToPlay()
            
            audioPlayer?.play()
        }
        catch {
            print("Couldn't load file: \(error.localizedDescription)")
        }
    }
    
    func checkAnswer(_ selected: String){
        if !imageSectionPassed {
            imageSectionPassed = Captcha.checkAnswer(selected: selected)
            if imageSectionPassed {
                GerrrrroooobWithsitAudio()
            }
        }
        else if !audioSectionPassed {
            audioSectionPassed = Captcha.checkAnswerAudio(selected: selected)
                
                if audioSectionPassed {
                    print("Captcha Complete!")
                }
            }
        
    }
    
    
    func ImageHelper(_ imageName: String) -> some View {
        if let path = Bundle.main.path(
            forResource: imageName.replacingOccurrences(of: ".png", with: ""),
            ofType: "png"
        ),
           let uiImage = UIImage(contentsOfFile: path) {
            
            return AnyView(Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 109, height: 28)
            )
        }
        
        return AnyView(Image("son"))
    }
    
    func GerrrrroooobWithsitImagery(){
        Captcha.loadAssets()
        
        
        Captcha.generateVisualCaptcha()
        print("Loaded images:", Captcha.imageOptions)
        print("Correct:", Captcha.correctImage)
        imageOptions = Captcha.imageOptions
        
        Started.toggle()
        
    }
    
    func GerrrrroooobWithsitAudio(){
        
        
        Captcha.generateAudioCaptcha()
        print("Loaded audio:", Captcha.AudioOptions)
        print("Correct:", Captcha.correctAudio)
        AudioOptions = Captcha.AudioOptions
    
        
    }
    
    func reset(){
        Captcha.resetAttempts()
        imageSectionPassed = false
        audioSectionPassed = false
    }
}

#Preview {
    ContentView()
}
