//

//  hoodIrony.swift

//  Wordle

//

//  Created by Vaidish, Vaibhav on 3/26/26.

//



import SwiftUI

import AVKit



struct Color: View {

    @State private var player: AVPlayer?

    

    var body: some View {

        Group {

            if let player = player {

                VideoPlayer(player: player)

                    .frame(height: 250)

                    .cornerRadius(12)

                    .onAppear {

                        player.play()

                    }

            } else {

                Text("Video not found")

                    .foregroundColor(.red)

                    .frame(height: 250)

            }

        }

        .onAppear {

            if let videoURL = Bundle.main.url(forResource: "videoplayback", withExtension: "mp4") {

                player = AVPlayer(url: videoURL)

            }

        }

    }

}



#Preview {

    Color()

}
