import SwiftUI

struct RadioView: View {
    @State private var selectedOption = 0
    private let options = ["David Attenborough", "Donald Trump", "Obi-Wan Kenobi"]
    
    var body: some View {
        VStack {
            
            RadioGroupPicker(options: options, selectedOption: $selectedOption)
        }
        .padding()
    }
}

struct RadioGroupPicker: View {
    let options: [String]
    @Binding var selectedOption: Int
    
    var body: some View {
        VStack(alignment: .leading) {
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
