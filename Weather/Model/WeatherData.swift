struct Weather {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainInfo {
    let temp: Double
    let pressure: Int
    let humidify: Int
}

struct WeatherData {
    let weather: [Weather]
    let mainInfo: MainInfo
    let name: String
    let id: Int
}
