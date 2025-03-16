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
    
    var dataValues: [Double] = []
    
    var xAxisStrideCount: Int {
        Int(dataValues.count/6)
    }
    
    var min: Double { dataValues.min() ?? 0 }
    var max: Double { dataValues.max() ?? 0 }
    
    var xStartDateString: String {
        // 7 days previously
        var components = DateComponents()
        components.day = -7
        let now = Date()
        let date = Calendar.current.date(byAdding: components, to: now) ?? Date()
    
        let formatter = DateFormatter()
        formatter.dateFormat = "M.dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
    
    var xEndDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M.dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: .now)
    }
    
    func dateForXAxisValue(_ xValue: Int) -> String {
        guard xValue > 0 else {
            return xStartDateString
        }
        guard xValue < (dataValues.count) else {
            return xEndDateString
        }
        
        return ""
    }
    
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
