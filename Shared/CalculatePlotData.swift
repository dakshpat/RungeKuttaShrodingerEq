//
//  CalculatePlotData.swift
//  SwiftUICorePlotExample
//
//  Created by Jeff Terry on 12/22/20.
//

import Foundation
import SwiftUI
import CorePlot

class CalculatePlotData: NSObject, ObservableObject {
    @Published var energyStep = 0.10
    @Published var eMin = 0.0
    @Published var eMax = 50.0
    var plotData :[plotDataType] =  []
    var oneDPotentialXArray:[Double] = []
    var oneDPotentialYArray:[Double] = []
    var oneDPotentialArray:[Double] = []
    var count = 0
    
    @ObservedObject var recursion = recursionClass()
    
    var plotDataModel: PlotDataClass? = nil

    func shootingMethodPlot(potential: [Double])
    {
        
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "Energy(eV)"
        plotDataModel!.changingPlotParameters.yLabel = "Psi"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = "Functional"
        plotDataModel!.zeroData()
        
        
        var plotData :[plotDataType] =  []
        //let eMin = 0.0
        //let eMax = 10.0
        
        for energy in stride(from: eMin, through: eMax, by: energyStep) {
            
            let functionalValue = recursion.shootingMethod(xSteps: energyStep, guessEnergy: energy, potential: potential)
            
            let dataPoint: plotDataType = [.X: energy, .Y: functionalValue]
            plotData.append(contentsOf: [dataPoint])
            
            
            
            
        }

        plotDataModel!.appendData(dataPoint: plotData)
        
        
    }
    
    
    func rK4th (potential: [Double]){

        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "Energy(eV)"
        plotDataModel!.changingPlotParameters.yLabel = "Psi"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = "Functional"
        plotDataModel!.zeroData()


        var plotData :[plotDataType] =  []
        //let eMin = 0.0
        //let eMax = 20.0
        for energy in stride(from: eMin, through: eMax, by: energyStep) {

            let functionalValue = recursion.rKFourth(xSteps: energyStep, guessEnergy: energy,potential: potential)

            let dataPoint: plotDataType = [.X: energy, .Y: functionalValue] // create single point?
            plotData.append(contentsOf: [dataPoint]) // append single point to an array?




        }

        plotDataModel!.appendData(dataPoint: plotData)


    }
    
    
    func PEx(dataPoints: [(xPoint: Double, yPoint: Double)]){
        

        for item in dataPoints{
            
            let x = item.xPoint
            let y = item.yPoint
            
            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
        }
        
        plotDataModel!.changingPlotParameters.yMax = 30.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = " y = x"
        plotDataModel!.zeroData()
        plotDataModel!.appendData(dataPoint: plotData)

        
}
    
    
    
    func plotPsi(energy: Double, potential: [Double])
    {
        
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "Energy(eV)"
        plotDataModel!.changingPlotParameters.yLabel = "Psi"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = "Functional"
        plotDataModel!.zeroData()
        

        var plotData :[plotDataType] =  []
        //let eMin = 0.0
        //let eMax = 10.0
        
            
        let PsiPoints = recursion.PlotPsi(deltaX: energyStep, energy: energy, potential: potential)
        
        for points in PsiPoints{
            
            let dataPoint: plotDataType = [.X: points.xPoint, .Y: points.yPoint]
            
            plotData.append(contentsOf: [dataPoint])
        }
            

        plotDataModel!.appendData(dataPoint: plotData)
        
        
    }

}
