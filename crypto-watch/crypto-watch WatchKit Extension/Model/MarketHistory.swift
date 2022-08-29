//
//  MarketHistory.swift
//  crypto-watch WatchKit Extension
//
//  Created by Jonatan Scaglia on 29/08/2022.
//

import Foundation

struct MarketHistory: Decodable, Hashable {
    var id:String
    var symbol:String
    var name: String
    var current_price: Float
    var price_change_24h: Float
    var price_change_percentage_24h: Float
    var sparkline_in_7d: Price
}

struct Price: Decodable, Hashable{
    var price: [Float]
}
