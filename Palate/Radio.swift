import SwiftUI

struct RadioView: View {
    @State private var selectedOption = 0
    private let options = ["Attenborough", "Trump", "Kenobi"]
    
    var body: some View {
        VStack {
            
            RadioGroupPicker(options: options, selectedOption: $selectedOption)
        }
        .padding()
    }
}

struct RadioGroupPicker: View {
    let options: [String]
    @Binding var selectedOption: Int {
        didSet {
            print("selection is now: \(selectedOption)")
            ContentView.playerView.initialiseAudioPlayer(selection: selectedOption)
        }
    }
    
    var body: some View {
        HStack() {
            ForEach(0..<options.count) { index in
                RadioButtonRowView(label: options[index],
                                   isSelected: index == selectedOption)
                    .onTapGesture {
                        selectedOption = index
                    }
            }
        }
    }
}

struct RadioButtonRowView: View {
    let label: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
            
            Text(label)
        }
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        RadioView()
    }
}
