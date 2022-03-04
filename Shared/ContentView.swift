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
    @ObservedObject var calculator = CalculatePlotData()
    @ObservedObject var potentials = InfiniteSquarePotentials()
    @State var stringMaxEnergy = ""
    @State var stringEnergyStep = ""

    @State var isChecked:Bool = false
    @State var tempInput = ""
  

    var body: some View {
        
        HStack{
            VStack{
                
                
                HStack {
                    Text("Max energy:")
                    TextField("energyMax: ", text: $stringMaxEnergy)
                        .frame(width: 100)
                }
                
                HStack {
                    Text("Energy Step:")
                    TextField("Energy Step: ", text: $stringEnergyStep)
                        .frame(width: 100)
                }
                
                
                Menu("RK1") {
                    
                    Button("Square Well", action: {self.calculateFunctional(potentialType: "Square Well")})
                    Button("Linear Well", action: {self.calculateFunctional(potentialType: "Linear Well")})
                    Button("Parabola", action: {self.calculateFunctional(potentialType: "Parabola")})
                }
                .padding()
                .frame(width: 200)
            
                Menu("Runge Kutta 4th") {
                    
                    Button("Square Well", action: {self.calculateFunctional2(potentialType: "Square Well")})
                    Button("Linear Well", action: {self.calculateFunctional2(potentialType: "Linear Well")})
                    Button("Parabola", action: {self.calculateFunctional2(potentialType: "Parabola")})
                }
                .padding()
                .frame(width: 200)
                
                
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
    
    func calculateFunctional2(potentialType: String){
        
        calculator.eMax = Double(stringMaxEnergy)!
        calculator.energyStep = Double(stringEnergyStep)!
            
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
                calculator.rK4th(potential: potentialVal)

        }
    
    
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
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
