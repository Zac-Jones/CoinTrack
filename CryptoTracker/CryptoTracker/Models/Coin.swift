//
//  Coin.swift
//  CryptoTracker
//
//  Created by Zac Jones on 9/5/2024.
//

import Foundation

struct Coin: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let currentPrice: Double
    let marketCap: Double
    let marketCapRank: Int
    let high24h: Double
    let low24h: Double
    let priceChange24h: Double
    let priceChangePercentage24h: Double
    let marketCapChange24h: Double
    let marketCapChangePercentage24h: Double
    let circulatingSupply: Double
    let totalSupply: Double?
    let maxSupply: Double?
    let ath: Double
    let athChangePercentage: Double?
    let athDate: Date?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: Date?
    let lastUpdated: Date?
    let sparklineIn7d: SparklineIn7d?
    var isFavourited: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case sparklineIn7d = "sparkline_in_7d"
        case ath, athChangePercentage, athDate, atl, atlChangePercentage, atlDate, lastUpdated
    }
    
    struct SparklineIn7d: Codable {
        let price: [Double]
        
        enum CodingKeys: String, CodingKey {
            case price
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            price = try container.decode([Double].self, forKey: .price)
        }
    }
}
