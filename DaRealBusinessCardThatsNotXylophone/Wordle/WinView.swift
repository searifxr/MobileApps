import SwiftUI
import AVKit

struct WinView: View {
    var onRestart: () -> Void
    
    var body: some View {
        VStack {
            Text("Good job! 🎉")
                .font(.largeTitle)
                .bold()
            
            VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "videoplayback", withExtension: "mp4")!))
                .frame(height: 250)
            
            Button("Play Again") {
                onRestart()
            }
            .padding()
        }
        .padding()
    }
}
