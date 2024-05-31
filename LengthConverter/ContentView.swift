//
//  ContentView.swift
//  LengthConverter
//
//  Created by Ambrose V on 31/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var numberAmount = 0.0
    @State private var startingUnit = "Inches"
    @State private var amountEntered: Bool = false
    @State private var finalUnit = "Centimeters"
    @FocusState private var amountIsFocused: Bool
    let american_units = ["Inches", "Feet", "Yards", "Miles"]
    let english_units = ["Centimeters", "Meters", "Kilometers"]
    var converter: Double {
        var amount = 0.0
        if startingUnit == "Inches" {
            amount = numberAmount * 2.54
        }
        else if startingUnit == "Feet" {
            amount = numberAmount * 30.48
        }
        else if startingUnit == "Yards" {
            amount = numberAmount * 91.44
        }
        else if startingUnit == "Miles" {
            amount = numberAmount * 160934
        }
        
        if finalUnit == "Centimeters" {
            //No change
        }
        else if finalUnit == "Meters" {
            amount = amount / 100
        }
        else if finalUnit == "Kilometers" {
            amount = amount / 1000
        }
        
        return amount
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Starting Unit") {
                    Picker("Starting Unit", selection: $startingUnit) {
                        ForEach(american_units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                Section("Final Conversion Unit") {
                    Picker("Final Unit", selection: $finalUnit) {
                        ForEach(english_units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                Section("Enter here amount to convert") {
                    TextField("Amount", value: $numberAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .onChange(of: numberAmount) { newValue in
                            amountEntered = (newValue != 0)
                                                }
                }
                Text("Result")
                Text(converter, format: .number)
                
            }
            .navigationTitle("Converter for Brits")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
