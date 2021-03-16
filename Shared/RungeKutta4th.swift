//
//  RungeKutta4th.swift
//  RungeKuttaShrodingerEq
//
//  Created by anthony lim on 3/12/21.
//

import Foundation
import SwiftUI
class potentialClass: ObservableObject {
    
    // the default is infinite square well
    
    var V = 0.0
    var xMin = 0.0
    var xMax = 10.0        // 0 to pi so sin(xMin) = 0 sin(xMax) = 0 to start
    
    let hbar = 6.582119569e-16  // in eV*s
    let mElectronInEVOverCSquared = 0.510998950e6 / (299792458 * 299792458)
    let hbarSquaredOverElectronMass = 7.61996423107385308868    // ev * ang^2
    
}   //end of potential class


class infiniteSquareWell: potentialClass {
    
}   //end of infinite square well class, nothing is changed since it is the default of potentialClass anyway


// should this be a subclass of potentialClass or not?
class recursionClass: infiniteSquareWell {
    
    @ObservedObject var waveFuncArrays = waveFunctionArrayClass()
                
    func shootingMethod(xSteps: Double, guessEnergy: Double) -> Double {

        var psi: [Double] = []
        var psiPrime: [Double] = []
        var psiDoublePrime: [Double] = []
        
        let energy = guessEnergy
        
        var i = 0
        
        // start with a guess for the slope at zero, and 2nd derivative of psi equal to zero
        psiPrime.append(5.0)
        psiDoublePrime.append(0.0)
        psi.append(0.0)
        
        let deltaX = xSteps
        
        for xValue in stride(from: xMin, through: xMax, by: xSteps) {
            psiPrime.append(psiPrime[i] + psiDoublePrime[i]*deltaX)
            psi.append(psi[i] + psiPrime[i]*deltaX)
            psiDoublePrime.append(-(2/hbarSquaredOverElectronMass) * psi[i+1] * energy)
            
            
            i += 1
            
        }
        
        // need to append psi prime and psi to their own sets of y points
        waveFuncArrays.psiArray.append(psi)
        waveFuncArrays.psiPrimeArray.append(psiPrime)
        
        //return plotData for now
        return psi[psi.count-1]
        
    }   // end of functional function
    

func rKFourth(xSteps: Double, guessEnergy: Double) -> Double {
    
    var psi: [Double] = []
    var psiPrime: [Double] = []
    var psiDoublePrime: [Double] = []
    var k1:[Double]=[]
    var y1:[Double] = []
    var k2:[Double]=[]
    var y2:[Double] = []
    var k3:[Double] = []
    var y3:[Double] = []
    var k4:[Double] = []
    var eSt:[Double] = []
    
    let energy = guessEnergy
    
    var i = 0
    
    // start with a guess for the slope at zero, and 2nd derivative of psi equal to zero
    psiPrime.append(5.0)
    psiDoublePrime.append(0.0)
    psi.append(0.0)
    
    let deltaX = xSteps
    
    for xValue in stride(from: xMin, through: xMax, by: xSteps) {
        psiPrime.append(psiPrime[i] + psiDoublePrime[i]*deltaX)
        psi.append(psi[i] + psiPrime[i]*deltaX)
        psiDoublePrime.append(-(2/hbarSquaredOverElectronMass) * psi[i+1] * energy)
        //k1 = f(t,y)
        k1.append(psiPrime[i] + psiDoublePrime[i]*deltaX)
        y1.append(k1[i]*xSteps/2.0 + psiPrime[i])
        //k2 = f(t+h/2, y+hk1/2)
        k2.append(psiPrime[i] *  psiDoublePrime[i]*deltaX)
        y2.append(k2[i]*xSteps/2.0 + psiPrime[i])
        //k3 = f(t+h/2, y+hk2/2)
        k3.append(psiPrime[i]*y2[i]*xSteps/2.0)
        y3.append(psiPrime[i] + k3[i]*deltaX)
        //k4 = f(t+h/2, y+hk3)
        k4.append(psiPrime[i]*y3[i]*xSteps)
        //y(h) = y + 1/6 (k1+2k2+2k3+k4) * h
        eSt.append(psi[i]+(k1[i]+2.0*k2[i]+2.0*k3[i]+k4[i])*xSteps/6.0)
        
        i += 1
        
    }
    
    // need to append psi prime and psi to their own sets of y points
    waveFuncArrays.psiArray.append(psi)
    waveFuncArrays.psiPrimeArray.append(eSt)
    
    //return plotData for now
    return eSt[eSt.count-1]
    
}

}   //end of recursion class
