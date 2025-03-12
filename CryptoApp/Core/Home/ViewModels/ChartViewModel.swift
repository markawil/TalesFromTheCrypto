//
//  ChartViewModel.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 3/12/25.
//

import Charts
import Foundation

struct ChartValue: Identifiable {
    let id = UUID()
    let xValue: PlottableValue<Int>
    let yValue: PlottableValue<Double>
}

class ChartViewModel: ObservableObject {
    
    @Published var lineChartData: [ChartValue] = []
    
    private var dataValues: [Double] = []
    
    var min: Double { dataValues.min() ?? 0 }
    var max: Double { dataValues.max() ?? 0 }
    
    init (dataValues: [Double]) {
        self.dataValues = dataValues
        generateData()
    }
    
    private func generateData() {
        
        lineChartData = dataValues.indices.map { index in
            ChartValue(
                xValue: PlottableValue.value("Index", index),
                yValue: PlottableValue.value("Value", dataValues[index])
            )
        }
    }
}
