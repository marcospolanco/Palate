//
//  ContentView.swift
//  Palate
//
//  Created by Marco’s Polanco on 6/3/23.
//

import SwiftUI
import AVFoundation

import CoreData
import AVKit
import SwiftAudioPlayer


struct SomeView: View {

    @State var showWebView = false

    var body: some View {
        ZStack {
            Button(action: {
                self.showWebView.toggle()

            }) {
                Text("Go To WebView")
                    .padding()
                    .foregroundColor(.black)
                    .font(.title)
            }
            .sheet(isPresented: $showWebView, content: {
                WebView(url: URL(string: "https://www.apple.com/")!) })

        }
    }
}

struct ContentView: View {
    
    @State private var showWebView = false
    @State var player: AVAudioPlayer?
    @State private var url = URL(string: "https://www.google.com")
    
    @State private var sliderValue1: Double = 0.5
    @State private var sliderValue2: Double = 0.25
    @State private var sliderValue3: Double = 0.75

    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.url, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            
            VStack {
                Text("Palate")

//                List {
//                    ForEach(items) { item in
//                        NavigationLink {
//                            Text("Item at \(item.url!, formatter: itemFormatter)")
//                        } label: {
//                            Text(item.url!, formatter: itemFormatter)
//                        }
//                    }
//                    .onDelete(perform: deleteItems)
//                }
//
                CarouselView()
                    .frame(maxHeight: 100)
                    .padding()
                
                VStack {
                    HStack{
                        Text("Time:")
                        
                        Slider(value: $sliderValue1)
                    }
                        .padding()
                    HStack{
                        Text("Complexity:")
                        
                        Slider(value: $sliderValue2)
                    }
                    HStack  {
                        Text("Language:")
                        
                        Slider(value: $sliderValue3)
                    }
                }.background(Color.white)

                
                RadioView()
                AudioPlayerView()
//            HStack {
//                Button(action: {
//                        guard let url = URL(string: "https://palate-output.s3.us-east-2.amazonaws.com/david.mp3") else {return}
//                        SAPlayer.shared.startRemoteAudio(withRemoteUrl: url)
//                        SAPlayer.shared.play()
//
//                }) {
//                    Image(systemName: "play.fill")
//                }
//
//                Button(action: {
//                    self.player?.pause()
//                }) {
//                    Image(systemName: "pause.fill")
//                }
//            }
            .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Palate")
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }.disabled(false)
                }
            }
            
            .sheet(isPresented: $showWebView) {
                WebView(url: url!)
            }
            
            Text("Select an item")
        }
        
        
    }

    private func addItem() {
        showWebView = true
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

class ListManager: NSObject {
    static let shared = ListManager()
}


extension ListManager {

}
