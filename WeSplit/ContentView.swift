//
//  ContentView.swift
//  WeSplit
//
//  Created by Aniket Sharma on 09/04/24.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = tipValue + checkAmount
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
    }
    var totalAmount : Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = tipValue + checkAmount
        
        return grandTotal
    }
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "IND"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?"){
                    

                    Picker("Tip Percentage",selection: $tipPercentage){
//                        ForEach(0..<101){
//                            Text($0,format: .percent)
//                        }
                        ForEach(tipPercentages,id: \.self){
                            Text($0,format: .percent)
                        }
                    }
//                    .pickerStyle(.navigationLink)
                    .pickerStyle(.segmented)
                }
                Section("Amount Per Person"){
                    Text( totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "IND"))
                }
                Section("Grand Total Amount of check"){
                    Text( totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "IND"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
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
