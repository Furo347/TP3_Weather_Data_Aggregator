// TP3 - Weather Data Aggregator
// Main Manager

import Foundation

final class WeatherAPIManager {
    static let shared = WeatherAPIManager()
    private init() {}

    func run() async {
        print("=== Weather Data Aggregator ===\n")

        // TODO 5.1: Créer array de 10 villes (1 pt)
        // Exemples: Paris (48.8566, 2.3522), London (51.5074, -0.1278), etc.
        let cities = [
            City(name: "Paris", latitude: 48.8566, longitude: 2.3522),
            City(name: "London", latitude: 51.5074, longitude: -0.1278),
            City(name: "Tokyo", latitude: 35.6762, longitude: 139.6503),
            City(name: "New York", latitude: 40.7128, longitude: -74.0060),
            City(name: "Sydney", latitude: -33.8688, longitude: 151.2093),
            City(name: "Berlin", latitude: 52.5200, longitude: 13.4050),
            City(name: "Moscow", latitude: 55.7558, longitude: 37.6173),
            City(name: "Dubai", latitude: 25.2048, longitude: 55.2708),
            City(name: "São Paulo", latitude: -23.5505, longitude: -46.6333),
            City(name: "Mumbai", latitude: 19.0760, longitude: 72.8777)
        ]

        // TODO 5.2: Créer WeatherCache + mesurer temps (1 pt)
        let cache = WeatherCache()
        let startTime = Date()

        // TODO 5.3: Appeler fetchMultipleCities et afficher résultats (2 pts)
        // ✓ Paris: 12.3°C, Wind: 15.2 km/h
        // ✗ London: Error - ...
        let results = await fetchMultipleCities(cities: cities, cache: cache)
        for (city, result) in results {
            switch result {
            case .success(let weather):
                print("✓ \(city.name): \(weather.temperature)°C, Wind: \(weather.windspeed) km/h")
            case .failure(let error):
                print("✗ \(city.name): Error - \(error)")
            }
        }

        // TODO 5.4: Calculer et afficher statistiques (3 pts)
        // - Total/Success/Failed
        // - Température avg/min/max
        // - Cache hits/misses/hit rate
        // - Temps d'exécution
        let endTime = Date()
        let total = results.count
        let successCount = results.filter { if case .success = $0.1 { return true } else { return false } }.count
        let failureCount = total - successCount
        let temperatures = results.compactMap { if case .success(let weather) = $0.1 { return weather.temperature } else { return nil } }
        let avgTemp = temperatures.reduce(0, +) / Double(temperatures.count)
        let minTemp = temperatures.min()
        let maxTemp = temperatures.max()
        let cacheStats = await cache.getStats()
        let hitRate = cacheStats.hits > 0 ? Double(cacheStats.hits) / Double(cacheStats.total) * 100 : 0
        let executionTime = endTime.timeIntervalSince(startTime)

        print("\n=== Statistics ===")
        print("Total: \(total), Success: \(successCount), Failed: \(failureCount)")
        print(String(format: "Temperature: Avg: %.2f°C, Min: %.2f°C, Max: %.2f°C", avgTemp, minTemp ?? 0, maxTemp ?? 0))
        print("Cache: Hits: \(cacheStats.hits), Misses: \(cacheStats.misses), Hit Rate: \(String(format: "%.2f", hitRate))%")
        print(String(format: "Execution Time: %.2f seconds", executionTime))
        
        // BONUS: Deuxième fetch pour tester le cache (+2 pts)
    }
}
