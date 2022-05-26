//
//  ContentView.swift
//  InAccessibility
//
//  Created by Jordi Bruin on 19/05/2022.
//

import SwiftUI

struct MainView: View {
    
    @State var showDetailStock: Stock?
    
    var body: some View {
        NavigationView {
            List {
                favoriteStocksSection
                allStocksSection
            }
            .navigationTitle("Stocks")
            .toolbar(content: {
                toolbarItems
            })
            .sheet(item: $showDetailStock) { stock in
                DetailView(stock: stock)
            }
        }
        .onAppear {
          print("💙\(Stock.all()[0].stockPrice)")
        }
    }

    
    var favoriteStocksSection: some View {
        Section {
            ForEach(Stock.favorites()) { stock in
                StockCell(stock: stock)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showDetailStock = stock
                    }
            }
        } header: {
            HStack {
                Text("Favorite Stocks")
                Spacer()
                Button {
                    
                } label: {
                    Text("Tap for more")
                }
                
            }
        } footer: {
            Text("Favorite stocks are updated every 1 minute.")
        }
        
    }
    //(String(format: "%.2f", stock.stockPrice)
    
    var allStocksSection: some View {
        Section {
            ForEach(Stock.all()) { stock in
                StockCell(stock: stock)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showDetailStock = stock
                    }
                    .accessibilityLabel(stock.name)
                    .accessibilityValue("\(Int(stock.stockPrice)) dollars and \(Int(round(stock.stockPrice.truncatingRemainder(dividingBy: 1)*100))) cents")
            }
        } header: {
            Text("All Stocks")
        }
    }
    
    var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                }
                .accessibilityElement(children: .ignore)
            }
        }
    }
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
