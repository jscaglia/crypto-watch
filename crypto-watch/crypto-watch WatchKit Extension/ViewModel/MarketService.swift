//
//  MarketService.swift
//  crypto-watch WatchKit Extension
//
//  Created by Jonatan Scaglia on 29/08/2022.
//

import Foundation

class MarketService: ObservableObject {
    @Published var marketCap = [MarketCap]()
    
    func getMarket() {
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=24h")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 2.
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let jsonData = data {
                    let decodedData = try JSONDecoder().decode([MarketCap].self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        self.marketCap = [MarketCap]()
                        self.marketCap.append(contentsOf: decodedData)
                    }
                    
                    
                } else {
                    print("No existen datos en el json recuperado")
                }
            } catch {
                print("Error: \(error)")
            }
        }.resume()
    }
    
    init(){
        getMarket()
    }
}
