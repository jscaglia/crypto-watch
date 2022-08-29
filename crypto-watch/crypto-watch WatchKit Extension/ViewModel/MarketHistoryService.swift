//
//  MarketHistoryService.swift
//  crypto-watch WatchKit Extension
//
//  Created by Jonatan Scaglia on 29/08/2022.
//

import Foundation

class MarketHistoryService: ObservableObject {
    @Published var marketHistory = [MarketHistory]()
    
    func getMarket(crypto: String) {
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=" + crypto + "&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 2.
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let jsonData = data {
                    let decodedData = try JSONDecoder().decode([MarketHistory].self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        self.marketHistory = [MarketHistory]()
                        self.marketHistory.append(contentsOf: decodedData)
                    }
                    
                    
                } else {
                    print("No existen datos en el json recuperado")
                }
            } catch {
                print("Error: \(error)")
            }
        }.resume()
    }
    
    
    init(crypto: String){
        getMarket(crypto: crypto)
    }
}
