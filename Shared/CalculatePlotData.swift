//
//  CalculatePlotData.swift
//  SwiftUICorePlotExample
//
//  Created by Jeff Terry on 12/22/20.
//

import Foundation
import SwiftUI
import CorePlot

class CalculatePlotData: ObservableObject {
    var energyStep = 0.10
    let eMin = 0.0
    let eMax = 10.0
    var plotData :[plotDataType] =  []
    var oneDPotentialXArray:[Double] = []
    var oneDPotentialYArray:[Double] = []
    var oneDPotentialArray:[Double] = []
    var count = 0
    
    @ObservedObject var recursion = recursionClass()
    
    var plotDataModel: PlotDataClass? = nil

    func shootingMethodPlot()
    {
        
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = " y = x"
        plotDataModel!.zeroData()
        
        
        var plotData :[plotDataType] =  []
        //let eMin = 0.0
        //let eMax = 10.0
        
        for energy in stride(from: eMin, through: eMax, by: energyStep) {
            
            let functionalValue = recursion.shootingMethod(xSteps: energyStep, guessEnergy: energy)
            
            let dataPoint: plotDataType = [.X: energy, .Y: functionalValue] // create single point?
            plotData.append(contentsOf: [dataPoint]) // append single point to an array?
            
            
            
            
        }

        plotDataModel!.appendData(dataPoint: plotData)
        
        
    }
    func rK4th (){
        
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = " y = x"
        plotDataModel!.zeroData()
        
        
        var plotData :[plotDataType] =  []
        //let eMin = 0.0
        //let eMax = 20.0
        for energy in stride(from: eMin, through: eMax, by: energyStep) {
            
            let functionalValue = recursion.rKFourth(xSteps: energyStep, guessEnergy: energy)
            
            let dataPoint: plotDataType = [.X: energy, .Y: functionalValue] // create single point?
            plotData.append(contentsOf: [dataPoint]) // append single point to an array?
            
            
            
            
        }

        plotDataModel!.appendData(dataPoint: plotData)
        
        
    }
    func PEx(){
        

        for i in stride(from: eMin+energyStep, through: eMax-energyStep, by: energyStep) {
            
            oneDPotentialXArray.append(i)
            oneDPotentialYArray.append((pow((i-(eMax+eMin)/2.0), 2.0)/1.0))
            
            count = oneDPotentialXArray.count
            let dataPoint: plotDataType = [.X: oneDPotentialXArray[count-1], .Y: oneDPotentialYArray[count-1]]
            plotData.append(contentsOf: [dataPoint])
        }
        plotDataModel!.changingPlotParameters.yMax = oneDPotentialYArray[count-1]+1.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = oneDPotentialXArray[count-1]+1.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = " y = x"
        plotDataModel!.zeroData()
        plotDataModel!.appendData(dataPoint: plotData)

        
}

}
