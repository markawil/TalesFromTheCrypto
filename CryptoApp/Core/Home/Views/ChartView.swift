//
//  ChartView.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 3/11/25.
//

import Charts
import SwiftUI

struct ChartView: View {
    
    let priceData: [Double]
    let linearGradient: LinearGradient
    
    private var viewModel: ChartViewModel
    
    private var coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        self.priceData = coin.sparklineIn7D?.price ?? []
        self.viewModel = ChartViewModel(dataValues: priceData)
        linearGradient = LinearGradient(gradient: Gradient(colors: [Color.theme.redColor.opacity(0.5), Color.theme.redColor.opacity(0.1)]),
                                        startPoint: .top,
                                        endPoint: .bottom)
    }
    var body: some View {
        Chart {
            ForEach(viewModel.lineChartData) { value in
                LineMark(x: value.xValue,
                         y: value.yValue)
                .foregroundStyle(Color.theme.redColor)
            }
            .interpolationMethod(.cardinal)
            
            ForEach(viewModel.lineChartData) { value in
                AreaMark(x: value.xValue,
                         yStart: value.yValue,
                         yEnd: PlottableValue.value("yMin", viewModel.min))
            }
            .interpolationMethod(.cardinal)
            .foregroundStyle(linearGradient)
        }
        .chartYScale(domain: (viewModel.min - viewModel.min/100)...(viewModel.max + viewModel.max/100))
        .chartXScale(domain: 0...(viewModel.lineChartData.count + 10))
        .chartYAxisLabel { Text("$USD") }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartXAxis {
            AxisMarks(preset: .aligned, values: .stride(by: Float(viewModel.xAxisStrideCount+1))) { value in
                let num = value.as(Int.self)!
                let day = viewModel.dateForXAxisValue(num)
                AxisGridLine()
                AxisValueLabel() {
                    Text("\(day)")
                }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: 200)
    }
}

struct ChartView_preview: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

    
