//
//  AudioPlayerView.swift
//  AccessibleAudioPlayer
//
//  Created by Laurent B on 30/10/2021.
//
import SwiftUI
import AVKit

struct AudioPlayerView: View {
    @State var audioPlayer: AVAudioPlayer?
    @State var progress: CGFloat = 0.0
    @State private var playing: Bool = false
    @State var duration: Double = 0.0
    @State var formattedDuration: String = ""
    @State var formattedProgress: String = "00:00"
    
    
    @State var selectedOption: Int = 0


    var body: some View {
        VStack {

            HStack {
                Text(formattedProgress)
                    .font(.caption.monospacedDigit())

                // this is a dynamic length progress bar
                GeometryReader { gr in
                    Capsule()
                        .stroke(Color.blue, lineWidth: 2)
                        .background(
                            Capsule()
                                .foregroundColor(Color.blue)
                                .frame(width: gr.size.width * progress, height: 8), alignment: .leading)
                }
                .frame( height: 8)

                Text(formattedDuration)
                    .font(.caption.monospacedDigit())
            }
            .padding()
            .frame(height: 50, alignment: .center)
            .accessibilityElement(children: .ignore)
            .accessibility(identifier: "audio player")
            .accessibilityLabel(playing ? Text("Playing at ") : Text("Duration"))
            .accessibilityValue(Text("\(formattedProgress)"))

            //             the control buttons
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                Button(action: {
                    guard let audioPlayer = self.audioPlayer else {return}
                    let decrease = audioPlayer.currentTime - 15
                    if decrease < 0.0 {
                        audioPlayer.currentTime = 0.0
                    } else {
                        audioPlayer.currentTime -= 15
                    }
                }) {
                    Image(systemName: "gobackward.15")
                        .font(.title)
                        .imageScale(.medium)
                }

                Button(action: {
                    guard let audioPlayer = self.audioPlayer else {return}
                    if audioPlayer.isPlaying {
                        playing = false
                        audioPlayer.pause()
                    } else if !audioPlayer.isPlaying {
                        playing = true
                        audioPlayer.play()
                    }
                }) {
                    Image(systemName: playing ?
                          "pause.circle.fill" : "play.circle.fill")
                        .font(.title)
                        .imageScale(.large)
                }

                Button(action: {
                    guard let audioPlayer = self.audioPlayer else {return}

                    let increase = audioPlayer.currentTime + 15
                    if increase < audioPlayer.duration {
                        audioPlayer.currentTime = increase
                    } else {
                        // give the user the chance to hear the end if he wishes
                        audioPlayer.currentTime = duration
                    }
                }) {
                    Image(systemName: "goforward.15")
                        .font(.title)
                        .imageScale(.medium)
                }
                Spacer()
            }
        }
        .foregroundColor(.blue)
        .onAppear {
            initialiseAudioPlayer()
        }
    }

    func initialiseAudioPlayer(selection: Int = 0) {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [ .pad ]
        
        let files: [Int:String] = [
            0: "david",
            1: "trump",
            2: "kenobi"
        ]

        // init audioPlayer
//        let path = Bundle.main.path(forResource: "david", ofType: "mp3")!
//        print(path)
        
        
        let audioURL = Bundle.main.url(forResource: files[selectedOption], withExtension: "mp3")!


        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            self.audioPlayer?.prepareToPlay()
//            self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        } catch let error {
            print("error creating audiplayer: \(error.localizedDescription)")
        }
        
        guard let audioPlayer = self.audioPlayer else {return print("crashed on nil audiplayer")}


        audioPlayer.setVolume(1.0, fadeDuration: 0)
        audioPlayer.prepareToPlay()

        //I need both! The formattedDuration is the string to display and duration is used when forwarding
        formattedDuration = formatter.string(from: TimeInterval(audioPlayer.duration))!
        duration = audioPlayer.duration

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if !audioPlayer.isPlaying {
                playing = false
            }
            progress = CGFloat(audioPlayer.currentTime / audioPlayer.duration)
            formattedProgress = formatter.string(from: TimeInterval(audioPlayer.currentTime))!
        }
    }
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView(selectedOption: 0)
            .previewLayout(PreviewLayout.fixed(width: 500, height: 300))
            .previewDisplayName("Default preview")
    }
}
