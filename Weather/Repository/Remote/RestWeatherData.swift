import ObjectMapper

class RestWeatherData: Mappable {
    
    var weather: [RestWeather]!
    var mainInfo: RestMainInfo!
    var name: String!
    var id: Int!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        weather <- map["weather"]
        mainInfo  <- map["main"]
        name <- map["name"]
        id <- map["id"]
    }
    
    func toEntity() -> WeatherData {
        return WeatherData(weather: weather.map { $0.toEntity() },
                           mainInfo: mainInfo.toEntity(),
                           name: name,
                           id: id)
    }
}

class RestWeather: Mappable {
    
    var id: Int!
    var main: String!
    var description: String!
    var icon: String!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        main  <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
    
    func toEntity() -> Weather {
        return Weather(id: id, main: main, description: description, icon: icon)
    }
}

class RestMainInfo: Mappable {
    
    var temp: Double!
    var pressure: Int!
    var humidity: Int!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        temp <- map["temp"]
        pressure  <- map["pressure"]
        humidity <- map["humidity"]
    }
    
    func toEntity() -> MainInfo {
        return MainInfo(temp: temp, pressure: pressure, humidify: humidity)
    }
}
