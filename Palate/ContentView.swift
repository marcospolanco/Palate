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


struct PreferencesView: View {

    @State private var sliderValue1: Double = 0.5
    @State private var sliderValue2: Double = 0.25
    @State private var sliderValue3: Double = 0.75

    var body: some View {
        VStack {
            HStack{
                Text("Time:")
                
                Slider(value: $sliderValue1)
            }
            HStack{
                Text("Complexity:")
                
                Slider(value: $sliderValue2)
            }
            HStack  {
                Text("Language:")
                
                Slider(value: $sliderValue3)
            }
        }
    }
}

struct MyButtonStyle: ButtonStyle {
 func makeBody(configuration: Self.Configuration) -> some View {
  configuration.label
   .padding()
   .foregroundColor(.black)
   .background(configuration.isPressed ? Color.clear : Color.clear)
   .cornerRadius(8.0)
 }
}


struct ContentView: View {
    
    @State private var showWebView = false
    @State var player: AVAudioPlayer?
    @State private var url = URL(string: "https://www.google.com")
    
    static let playerView = AudioPlayerView()
    

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.url, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
//    @Binding var text: String
    
    

    var body: some View {
        NavigationView {
            GeometryReader {metrics in
                VStack {
                    
                    Button(action: {
                        // Add your button action here
                        print("Button tapped")
                    }) {
                        if let url = Bundle.main.url(forResource: "palate_bg", withExtension: "png"),
                           let uiImage = UIImage(contentsOfFile: url.path) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .edgesIgnoringSafeArea(.bottom)
                    }
                    } .buttonStyle(MyButtonStyle())


                        
                        

                    ContentView.playerView.safeAreaInset(edge: .bottom, content:{
                        
                    }).frame(height: metrics.size.height * 0.2)
                }
            
            
            .toolbar {

                
                //                    ZStack {
                //
                //                        }
                //
                //                        HStack {
                ////                            TextField("Enter text", text: $text)
                ////                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                //                            Button(action: {
                //                                // Closure will be called once user taps your button
                ////                                print(self.$text)
                //                            }) {
                //                                Text("SEND")
                //                            }
                //                        }
                                        
                                    }
                //                    CarouselView().frame(height: metrics.size.height * 0.3)
                //                    PreferencesView().frame(height: metrics.size.height * 0.2)
                //                    RadioView().frame(height: metrics.size.height * 0.2)
                
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }.disabled(false)
//                }
            }
            
            .fullScreenCover(isPresented: $showWebView, content: {
                BrowserViewWrapper(isPresented: $showWebView, urlString: url?.absoluteString ?? "https://google.com")
            })
            
//            .sheet(isPresented: $showWebView) {
//                WebView(url: url!)
//            }
            
        }.background(Color.green)
        
        
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

//struct ContentView_Previews: PreviewProvider {
//    @Binding var defaultString:String
//    static var previews: some View {
//        ContentView(text: $defaultString).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}

class ListManager: NSObject {
    static let shared = ListManager()
}


extension ListManager {

}
