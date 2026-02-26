// TP3 - Weather Data Aggregator
// Weather Models

import Foundation

// 1. MODELS (2 pts)
// Décommenter et compléter les structures pour le décodage JSON

// TODO 1.1: CurrentWeather avec temperature, windspeed, weathercode
struct CurrentWeather: Decodable {
    let temperature: Double
    let windspeed: Double
    let weathercode: Int
}

// TODO 1.2: WeatherResponse avec latitude, longitude, currentWeather
// Astuce: "current_weather" dans le JSON -> utiliser CodingKeys
struct WeatherResponse: Decodable {
    let latitude: Double
    let longitude: Double
    let currentWeather: CurrentWeather
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case currentWeather = "current_weather"
    }
}

// TODO 1.3: City avec name, latitude, longitude
struct City {
    let name: String
    let latitude: Double
    let longitude: Double
}

// 2. ERRORS (1 pt)
// TODO 2.1: WeatherError avec cas invalidURL, networkError(String), decodingError(String)
enum WeatherError: Error {
    case invalidURL
    case networkError(String)
    case decodingError(String)
}
