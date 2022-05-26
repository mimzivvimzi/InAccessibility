//
//  StockCell.swift
//  InAccessibility
//
//  Created by Jordi Bruin on 19/05/2022.
//

import SwiftUI

struct StockCell: View {
    
    let stock: Stock
    
    @State var showInfo = false
  
    
    var body: some View {
      let goingUpInfo = stock.goingUp ? "Up" : "Down"

        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(stock.shortName)
                        .font(.system(size: 17))
                        .bold()
                        .accessibilityHidden(true)
                    
                    Image("info-icon")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .onTapGesture {
                            showInfo = true
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityHint("Tap for more info")

                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .opacity(stock.favorite ? 1 : 0)
                        .accessibilityHidden(true)
                }
                Text(stock.name)
                    .opacity(0.5)
                    .font(.system(size: 11))
                    .accessibilityHidden(true)
            }
            
            Spacer()
                
            StockGraph(stock: stock)
            .accessibilityHidden(true)

            StockPrice(stock: stock)
            .accessibilityHidden(true)

        }
        .accessibilityValue("Current share price is \(Int(stock.stockPrice)) dollars and \(Int(round(stock.stockPrice.truncatingRemainder(dividingBy: 1)*100))) cents. \(goingUpInfo) about \(Int(stock.change)) points")
        .accessibilityHint("Tap for more info")
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8))
        .alert(isPresented: $showInfo) {
            Alert(title: Text(stock.name), message: Text("The stock price for \(stock.name) (\(stock.shortName)) is \(stock.stockPrice)."), dismissButton: .cancel())
        }
    }
}

struct StockCell_Previews: PreviewProvider {
    static var previews: some View {
        StockCell(stock: .example())
    }
}

