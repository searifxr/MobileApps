import SwiftUI

struct ContentView: View {
    @State private var billText: String = ""
    @State private var tip: Double = 15.0
    @State private var split: Double = 1.0
    @State private var adOffset: CGFloat = 150
    
    // Ad State
    @State private var showPopup = false
    @State private var currentAdMessage = ""
    @State private var currentAdImage = "" // For image jumpscares
    @State private var isImageAd = false
    
    // Your bizarre text ads
    let bizarreAds = [
        "RENT YOUR ELBOW SPACE!", "BECOME A FULL-TIME GHOST", "BUY DEHYDRATED WATER",
        "SNAIL RACING SUBSCRIPTION", "MOON DUST (50% OFF)", "HOT VAIBHAVS IN YOUR AREA",
        "GET A PAIR OF SHOES", "DO YOU HAVE A HOLE IN YOUR SHOES?",
        "ENGINEERING STUDENTS PRANKING VAIBHAV SHOW!", "DARK NEBULAS COMING YOUR WAY",
        "10 GOON COINS, CLICK YES TO AFFIRM"
    ]
    
    // Names of images you upload to Assets.xcassets
    let jumpscareImages = ["DoesHeKnow", "Enrqiue", "Epstein", "MrFeast", "son", "continue", "DrHouse", "DrHouse2"]

    var body: some View {
        ZStack {
            // --- THE MAIN TRASH UI ---
            ScrollView {
                VStack(spacing: 5) {
                    marqueeSection
                    
                    Text("↓ INSERT CURRENCY ↓")
                        .font(.system(size: 8)).foregroundColor(.pink)
                    
                    TextField("0.00", text: $billText)
                        .background(Color.green).foregroundColor(.red)
                        .multilineTextAlignment(.center)

                    Text("TIP %").font(.caption2)
                    HStack {
                        Button("LESS") { tip -= 0.5 }.background(Color.gray)
                        Text("\(tip, specifier: "%.1f")%").font(.system(size: 20))
                        Button("MORE") { tip += 0.5 }.background(Color.blue)
                    }

                    let bill = Double(billText) ?? 0.0
                    let each = (bill * (1 + (tip / 100))) / max(1, split)
                    
                    Text("$\(each, specifier: "%.2f")")
                        .font(.system(size: 40, weight: .black))
                        .background(Color.black).foregroundColor(.white)
                    
                    Text("SCROLL FOR MORE AD CONTENT").font(.system(size: 7))
                    Color.clear.frame(height: 400) // Infinite void
                }
            }
            .background(Color.white)

            // --- THE JUMPSCARE / BIZARRE POP-UP LAYER ---
            if showPopup {
                ZStack {
                    Color.black.opacity(0.95).ignoresSafeArea()
                    
                    VStack {
                        if isImageAd {
                            // IMAGE JUMPSCARE
                            Image(currentAdImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .border(Color.red, width: 3)
                        } else {
                            // TEXT AD
                            Text("LIMITED TIME OFFER")
                                .font(.system(size: 8)).foregroundColor(.yellow)
                            
                            Text(currentAdMessage)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: 160)
                        }

                        Button(action: { showPopup = false }) {
                            Text("CLOSE [X]")
                                .font(.system(size: 8, weight: .heavy))
                                .padding(6)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        // The button moves randomly so they can't click it easily
                        .offset(x: CGFloat.random(in: -30...30), y: CGFloat.random(in: -30...30))
                    }
                    .padding()
                    .background(isImageAd ? Color.black : Color.purple)
                    .border(Color.white, width: 2)
                }
                .transition(.opacity)
            }
        }
        .onAppear {
            startChaosCycle()
        }
    }

    var marqueeSection: some View {
        ZStack {
            Color.yellow
            Text("HOT LAVA FOR SALE! --- BUY A THIRD THUMB! --- TAX YOUR FRIENDS!")
                .font(.system(size: 10, weight: .black))
                .foregroundColor(.blue)
                .fixedSize()
                .offset(x: adOffset)
                .onAppear {
                    withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                        adOffset = -300
                    }
                }
        }
        .frame(height: 25)
        .clipped()
    }

    func startChaosCycle() {
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            // 40% chance of an image jumpscare, 60% chance of a text ad
            isImageAd = Bool.random()
            
            if isImageAd {
                currentAdImage = jumpscareImages.randomElement() ?? ""
            } else {
                currentAdMessage = bizarreAds.randomElement() ?? "BUY NOTHING"
            }
            
            withAnimation(.spring()) {
                showPopup = true
            }
        }
    }
}

#Preview {
    ContentView()
}
