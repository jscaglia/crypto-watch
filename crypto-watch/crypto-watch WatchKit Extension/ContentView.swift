//
//  ContentView.swift
//  crypto-watch WatchKit Extension
//
//  Created by Jonatan Scaglia on 29/08/2022.
//

import SwiftUI

var cryptoSelected: MarketCap!

struct SheetBody: View {
    let hst: MarketHistory!
    var listPrice: [Float]!
    var maxValue: Float = 0.0
    
    @State var showCryptoPrice: Bool = false
    @State var cryptoSelected: String = " "
    @State var cryptoSelectedColor: Color = Color.clear
    
    var body: some View {
        VStack{
            HStack{
                ForEach(hst.sparkline_in_7d.price.prefix(15).indices, id: \.self) { price in
                    let current = Double(listPrice[price])
                    if(price != 0){
                        Button {
                            showCryptoPrice = true
                            self.cryptoSelected = String(format: "%.2f", current)
                            self.cryptoSelectedColor = listPrice[price] > listPrice[(price - 1)] ? Color.green : Color.red
                        } label: {
                            Rectangle().frame(height: (current * 100.0) / Double(maxValue), alignment: .bottom)
                        }.background((listPrice[price] > listPrice[(price - 1)]) ? Color.green : Color.red)
                        
                    } else{
                        Button {
                            showCryptoPrice = true
                            self.cryptoSelected = String(format: "%.2f", current)
                            self.cryptoSelectedColor = Color.green
                        } label: {
                            Rectangle().foregroundColor(Color.green).frame(height: (current * 100.0) / Double(maxValue), alignment: .bottom)
                            
                        }.background(Color.green)
                    }
                }
            }.frame(height: 70.0, alignment: .top).padding()
            
            HStack{
                if(cryptoSelected != " "){
                    Text("USD/" + String(hst.symbol.uppercased()) + ": ").foregroundColor(.white).bold().font(.system(size: 16.0))
                }
                
                Text(cryptoSelected).font(.title3).foregroundColor(cryptoSelectedColor)
            }
            
        }
        
    }
    
    init(hst: MarketHistory){
        self.hst = hst
        self.listPrice = Array(hst.sparkline_in_7d.price.prefix(15))
        self.maxValue = self.listPrice.max() ?? 0.0
    }
}

struct SheetHeader: View{
    let hst: MarketHistory!
    
    var body: some View {
        HStack{
            Image(hst.symbol.uppercased()).resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40, alignment: .top).cornerRadius(50.0)
            
            VStack{
                Text("USD/" + String(hst.symbol.uppercased())).foregroundColor(.white).bold().font(.system(size: 12.0)).frame(maxWidth: .infinity, alignment: .leading)
                Text(String(hst.current_price)).bold().foregroundColor((hst.price_change_24h > 0) ? .green : .red).font(.system(size: 12.0)).frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack{
                Text("%24H:").font(.system(size: 10.0))
                Text(String(format: "%.2f", hst.price_change_percentage_24h) + "%").font(.system(size: 12.0)).foregroundColor((hst.price_change_percentage_24h > 0 ? .green : .red))
            }
        }
    }
    
    init(hst: MarketHistory){
        self.hst = hst
    }
}

struct SheetView: View {
    @ObservedObject var history = MarketHistoryService(crypto: cryptoSelected.id)
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack{
            ForEach(history.marketHistory.prefix(10), id: \.self) { hst in
                SheetHeader(hst: hst)
                Divider()
                SheetBody(hst: hst)
            }
        }
    }
    
    init(marketDataId: MarketCap){
        cryptoSelected = marketDataId
    }
}

struct ContentView: View {
    @ObservedObject var market = MarketService()
    @State private var showingSheet = false
    
    var body: some View {
        TabView {
            VStack{
                ScrollView {
                    VStack {
                        ForEach(market.marketCap, id: \.self) {
                            marketObj in
                            
                            if UIImage(named: marketObj.symbol.uppercased()) != nil {
                                Button {
                                    cryptoSelected = marketObj
                                    showingSheet.toggle()
                                } label: {
                                    ItemList(marketData: marketObj)
                                }
                                .sheet(isPresented: $showingSheet) {
                                    SheetView(marketDataId: cryptoSelected)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
            .tabItem {
                Text("")
            }
            
            Text("Segunda Vista").tabItem {
                Text("")
            }
            
            Text("Tercer Vista").tabItem {
                Text("")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
