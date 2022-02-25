//
//  ContentView.swift
//  Shared
//
//  Created by daksh patel on 3/12/21.
//

import SwiftUI
import CorePlot

typealias plotDataType = [CPTScatterPlotField : Double]

struct ContentView: View {
    @EnvironmentObject var plotDataModel :PlotDataClass
    @ObservedObject private var calculator = CalculatePlotData()
    @ObservedObject var potentials = InfiniteSquarePotentials()

    @State var isChecked:Bool = false
    @State var tempInput = ""
  
    

    var body: some View {
        
        HStack{
            VStack{
                
                Menu("Calculate Functional") {
                    
                    Button("Square Well", action: {self.calculateFunctional(potentialType: "Square Well")})
                    Button("Linear Well", action: {self.calculateFunctional(potentialType: "Linear Well")})
                    Button("Parabola", action: {self.calculateFunctional(potentialType: "Parabola")})
                }
                .padding()
                .frame(width: 200)
            
        
                
//                Button("Runge Kutta 4th", action: {self.calculate2()})
//                .padding()
                
                Menu("Potential") {
                    
                    Button("Square Well", action: {self.selectPotential(potentialType: "Square Well")})
                    Button("Linear Well", action: {self.selectPotential(potentialType: "Linear Well")})
                    Button("Parabola", action: {self.selectPotential(potentialType: "Parabola")})
                }
                .padding()
                .frame(width: 200)
            }
            
            Divider()
            
            CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
                .aspectRatio(1, contentMode: .fit)
            

            
        }
        
    }

    
    
    
    
    /// calculate
    /// Function accepts the command to start the calculation from the GUI
func calculateFunctional(potentialType: String){
        
        var potentialVal = [Double]()
        
        
        switch potentialType {
        
            case "Square Well":
                potentials.zero()
                
            case "Linear Well":
                potentials.yEqualsX()
            
            case "Parabola":
                potentials.parabola()
            
            default:
                potentials.zero()
        }
    
        for item in potentials.potentialArray{
            potentialVal.append(item.yPoint)
        }
    
            //$calculator.energyStep_ = Double(tempInput)
            //pass the plotDataModel to the cosCalculator
            calculator.plotDataModel = self.plotDataModel
            
            //Calculate the new plotting data and place in the plotDataModel
            calculator.shootingMethodPlot(potential: potentialVal)

    }
    
//    func calculate2(){
//
//        //var temp = 0.0
//
//        //pass the plotDataModel to the cosCalculator
//        calculator.plotDataModel = self.plotDataModel
//
//        //Calculate the new plotting data and place in the plotDataModel
//
//        calculator.rK4th()
//
//
//    }
    
    func selectPotential(potentialType: String) {
        switch potentialType {
        
            case "Square Well":
                potentials.zero()
                
            case "Linear Well":
                potentials.yEqualsX()
            
            case "Parabola":
                potentials.parabola()
            
            default:
                potentials.zero()
        }
        
            //$calculator.energyStep_ = Double(tempInput)
            //pass the plotDataModel to the cosCalculator
            calculator.plotDataModel = self.plotDataModel
            
            //Calculate the new plotting data and place in the plotDataModel
            calculator.PEx(dataPoints: potentials.potentialArray)

        
    }
    
//    func potentialType(type: String){
//
//        potentials.parabola()
//
//
//        //$calculator.energyStep_ = Double(tempInput)
//        //pass the plotDataModel to the cosCalculator
//        calculator.plotDataModel = self.plotDataModel
//
//        //Calculate the new plotting data and place in the plotDataModel
//        calculator.PEx(dataPoints: potentials.potentialArray)
//
//
//    }
    

   
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
