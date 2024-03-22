//
//  ContentView.swift
//  swiftUI_assign3
//
//  Created by StudentAM on 3/5/24.
//

import SwiftUI

struct ContentView: View {
    //variables and arr to hold buttons (butts)
    @State private var inpOutpBox = "0"
    @State private var holderVar = "0"
    @State private var butts = [
        ["AC", "⁺∕₋", "%", "÷"],
        ["7", "8","9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    @State private var selectedOp: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                //the inputs and outputs box
                Text(inpOutpBox)
                    .foregroundColor(.white)
                    .font(.system(size:76))
            }
            ForEach(butts, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            if button == "AC"{
                                self.funcClicked()
                            }else if button == "⁺∕₋"{
                                self.signToggle()
                            }else if button == "+"{
                                self.addition()
                            }else if button == "-"{
                                self.subtraction()
                            }else if button == "×"{
                                self.multiplication()
                            }else if button == "÷"{
                                self.division()
                            }else if button == "="{
                                self.equals()
                            }else{
                                self.appToInp(value: button)
                            }
                        }) {
                            Circle()
                                .fill(Color(red: 0.225, green: 0.225, blue: 0.225))
                                                .frame(width: 75, height: 75) // Adjust size as needed
                                                .overlay(
                                                    Text(button)
                                                        .foregroundColor(.white)
                                                )
                        }.font(.system(size:35))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
    }
    func appToInp(value: String) {
        if inpOutpBox == "0" && value != "."{
            inpOutpBox = value
        }else if inpOutpBox == "-0"{
            inpOutpBox = "-"
        }else{
            inpOutpBox += value
        }
    }
    //ac and other funcs
    func funcClicked(){
        inpOutpBox = "0"
        holderVar = "0"
    }
    //not ac
    func otherFuncClicked(){
        holderVar = inpOutpBox
        funcClicked()
    }
    func addition(){
        selectedOp = "+"
        // Convert the current input box and the holder variable to doubles
        guard let inpOutpBoxNum = Double(inpOutpBox), let holderVarNum = Double(holderVar) else {
            // If conversion fails, set the input box to "Error" or handle the error appropriately
            inpOutpBox = "Error"
            return
        }
        let add = holderVarNum + inpOutpBoxNum
        holderVar = String(add)
        inpOutpBox = "0"
    }
    
    func subtraction(){
        selectedOp = "-"
        // Convert the current input box and the holder variable to doubles
        guard let inpOutpBoxNum = Double(inpOutpBox), let holderVarNum = Double(holderVar) else {
            // If conversion fails, set the input box to "Error" or handle the error appropriately
            inpOutpBox = "Error"
            return
        }
        let subtract = holderVarNum - inpOutpBoxNum
        holderVar = String(subtract)
        inpOutpBox = "0"
    }
    
    func multiplication(){
        selectedOp = "×"
        // Convert the current input box and the holder variable to doubles
        guard let inpOutpBoxNum = Double(inpOutpBox), let holderVarNum = Double(holderVar) else {
            // If conversion fails, set the input box to "Error" or handle the error appropriately
            inpOutpBox = "Error"
            return
        }
        let multiply = holderVarNum * inpOutpBoxNum
        holderVar = String(multiply)
        inpOutpBox = "0"
    }
    
    func division(){
        selectedOp = "÷"
        // Convert the current input box and the holder variable to doubles
        guard let inpOutpBoxNum = Double(inpOutpBox), let holderVarNum = Double(holderVar) else {
            // If conversion fails, set the input box to "Error" or handle the error appropriately
            inpOutpBox = "Error"
            return
        }
        let divide = holderVarNum / inpOutpBoxNum
        holderVar = String(divide)
        inpOutpBox = "0"
    }
    
    func signToggle(){
        if inpOutpBox.hasPrefix("-"){
            inpOutpBox.removeFirst()
        }else{
            inpOutpBox = "-" + inpOutpBox
        }
    }
    
    func percentage(){
        guard let value = Double(inpOutpBox) else {return}
        let result = value/100
        inpOutpBox = String(result)
    }
    
    func equals(){
        guard let inpOutpBoxNum = Double(inpOutpBox), let holderVarNum = Double(holderVar) else {
                inpOutpBox = "Error"
                return
            }
            
            let operations: [String: (Double, Double) -> Double] = [
                "+": { $0 + $1 },
                "-": { $0 - $1 },
                "×": { $0 * $1 },
                "÷": { $0 / $1 }
            ]
            
            guard let operation = operations[selectedOp] else {
                return
            }
        
            let result = operation(holderVarNum, inpOutpBoxNum)
        
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            let intResult = Int(result)
            inpOutpBox = "\(intResult)"
        } else {
            inpOutpBox = "\(result)"
        }
    }
}
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

