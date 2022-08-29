//
//  Market.swift
//  crypto-watch WatchKit Extension
//
//  Created by Jonatan Scaglia on 29/08/2022.
//

import Foundation

struct MarketCap:Codable, Hashable {
    var id:String
    var symbol:String
    var name: String
    var current_price: Float
    var price_change_24h: Float
    var price_change_percentage_24h: Float
    
    init(id: String, symbol: String, name: String, currentPrice: Float, price24: Float, priceChange24: Float){
        self.id = id
        self.symbol = symbol
        self.name = name
        self.current_price = currentPrice
        self.price_change_24h = price24
        self.price_change_percentage_24h = priceChange24
    }
}
