//
//  ContentView.swift
//  UnitConvert
//
//  Created by Jaydev Shah on 12/18/19.
//  Copyright © 2019 Jaydev Shah. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var unitType = 0
    @State private var inputType = 0
    @State private var outputType = 0
    @State private var inputValue = "0"
    
    private var outputValue: Double? {
        guard var tempInput = Double(inputValue) else {
            return nil
        }
        switch unitType {
        case 0: // Length
            if tempInput < 0 { return nil }
            switch inputType {
            case 0: // MM
                break
            case 1: // M
                tempInput *= 1000
            case 2: // KM
                tempInput *= 1000 * 1000
            case 3: // Inch
                tempInput *= 25.4
            case 4: // Foot
                tempInput *= 25.4 * 12
            case 5: // Mile
                tempInput *= 25.4 * 12 * 5280
            default: // Other
                return nil
            }
            switch outputType {
            case 0: // MM
                return tempInput
            case 1: // M
                return tempInput / 1000
            case 2: // KM
                return tempInput / 1000 / 1000
            case 3: // Inch
                return tempInput / 25.4
            case 4: // Foot
                return tempInput / 25.4 / 12
            case 5: // Mile
                return tempInput / 25.4 / 12 / 5280
            default: // Other
                return nil
            }
            
        case 1: // Time
            if tempInput < 0 { return nil }
            switch inputType {
            case 0: // Sec
                break
            case 1: // Min
                tempInput *= 60
            case 2: // Hour
                tempInput *= 60 * 60
            case 3: // Day
                tempInput *= 86400
            case 4: // Week
                tempInput *= 86400 * 7
            case 5: // Year
                tempInput *= 86400 * 365
            default: // Other
                return nil
            }
            switch outputType {
            case 0: // Sec
                return tempInput
            case 1: // Min
                return tempInput / 60
            case 2: // Hour
                return tempInput / 60 / 60
            case 3: // Day
                return tempInput / 86400
            case 4: // Week
                return tempInput / 86400 / 7
            case 5: // Year
                return tempInput / 86400 / 365
            default: // Other
                return nil
            }
            
        case 2: // Temp
            switch inputType {
            case 0: // Farenheit
                tempInput = (tempInput - 32) * 5 / 9
            case 1: // Celsius
                break
            case 2: // Kelvin
                tempInput -= 273.15
            default: // Other
                return nil
            }
            if tempInput < -273.15 { return nil }
            switch outputType {
            case 0: // Farenheit
                return ((tempInput * 9 / 5) + 32)
            case 1: // Celsius
                return tempInput
            case 2: // Kelvin
                return tempInput + 273.15
            default: // Other
                return nil
            }
            
        case 3: // Volume
            if tempInput < 0 { return nil }
            switch inputType {
            case 0: // ML
                break
            case 1: // L
                tempInput *= 1000
            case 2: // Cup
                tempInput *= 284.131
            case 3: // Gallon
                tempInput *= 284.131 * 16
            default: // Other
                return nil
            }
            switch outputType {
            case 0: // ML
                return tempInput
            case 1: // L
                return tempInput / 1000
            case 2: // Cup
                return tempInput / 284.131
            case 3: // Gallon
                return tempInput / 284.131 / 16
            default: // Other
                return nil
            }
            
        default: // Other
            return nil
        }
    }

    let unitTypes = ["Length", "Time", "Temp", "Volume"]
    let allUnits = [["MM", "M", "KM", "Inch", "Foot", "Mile"],
                    ["Sec", "Min", "Hr", "Day", "Week", "Year"],
                    ["Farenheit", "Celsius", "Kelvin"],
                    ["ML", "L", "Cup", "Gallon"]]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Choose type of unit")) {
                    Picker("Type of unit", selection: $unitType) {
                        ForEach (0 ..< self.unitTypes.count) {
                            Text("\(self.unitTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Input")) {
                    Picker("Type of unit", selection: $inputType) {
                        ForEach (0 ..< self.allUnits[self.unitType].count, id: \.self) {
                            Text("\(self.allUnits[self.unitType][$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    TextField("Input", text: $inputValue)
                    .keyboardType(.decimalPad)
                }
                Section(header: Text("Output")) {
                    Picker("Type of unit", selection: $outputType) {
                        ForEach (0 ..< self.allUnits[self.unitType].count, id: \.self) {
                            Text("\(self.allUnits[self.unitType][$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Text("\(outputValue?.clean ?? "Err")")
                }
            }
        .navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
