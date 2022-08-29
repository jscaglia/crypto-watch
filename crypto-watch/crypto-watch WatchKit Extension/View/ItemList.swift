//
//  ItemList.swift
//  crypto-watch WatchKit Extension
//
//  Created by Jonatan Scaglia on 29/08/2022.
//

import SwiftUI

struct ItemList: View {
    var market: MarketCap;
    var body: some View {
        VStack{
            HStack {
                VStack{
                    Text("USD/" + String(market.symbol.uppercased())).foregroundColor(.white).bold().font(.system(size: 12.0)).frame(maxWidth: .infinity, alignment: .leading)
                    Text("$" + String(market.current_price)).bold().foregroundColor((market.price_change_24h > 0) ? .green : .red).font(.system(size: 12.0)).frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack{
                    
                    Text("%24H:").font(.system(size: 10.0))
                    Text(String(format: "%.2f", market.price_change_percentage_24h) + "%").font(.system(size: 12.0)).foregroundColor((market.price_change_percentage_24h > 0 ? .green : .red))
                }
                
                Image(market.symbol.uppercased()).resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .leading).cornerRadius(50.0)
            }
            Divider().foregroundColor(.blue).frame(height: 2)
        }
    }
    
    init(marketData: MarketCap){
        market = marketData
    }
}
