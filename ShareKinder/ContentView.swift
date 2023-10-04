//
//  ContentView.swift
//  ShareKinder
//
//  Created by Hass on 9/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background image
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Custom glowing title
                    Text("ShareKinder")
                        .font(.largeTitle)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing), lineWidth: 4).shadow(color: Color.green.opacity(0.8), radius: 15, x: 0, y: 0))
                    
                    Spacer()
                    
                    // Form contents
                    VStack {
                        Group {
                            HStack {
                                TextField("Amount", value: $checkAmount, format:
                                    .currency(code: Locale.current.currencyCode ?? "USD"))
                                    .keyboardType(.decimalPad)
                                    .focused($amountIsFocused)
                                    .font(.title)
                                    .padding()
                                    .background(Color.white.opacity(0.3))
                                    .cornerRadius(10)
                                
                                Picker("Number of People", selection: $numberOfPeople) {
                                    ForEach(2..<100) {
                                        Text("\($0) people")
                                    }
                                }
                                .font(.title)
                            }
                            .padding(.horizontal)

                            Picker("Tip Percentage", selection: $tipPercentage) {
                                ForEach(tipPercentages, id: \.self) {
                                    Text("\($0)%")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .font(.title)
                            .padding(.horizontal)
                        }
                        .padding(.vertical)

                        Group {
                            Text("Amount per person: \(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                                .font(.title)
                                .padding(.horizontal)

                            Text("Total amount: \(totalAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                                .font(.title)
                                .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green, Color.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 6).shadow(color: Color.green.opacity(0.8), radius: 15, x: 0, y: 0))
                    .cornerRadius(15)
                    .frame(maxWidth: 400, alignment: .center)
                    .padding(.horizontal)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
