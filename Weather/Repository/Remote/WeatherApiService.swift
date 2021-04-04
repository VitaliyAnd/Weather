import Moya

private let apiKey = "2d76a468784a2b76b9f3e74bfa1fc880"

enum WeatherApiService {
    
    case getWeatherData(name: String)
    
}

extension WeatherApiService: TargetType {
    
    
    var path: String {
        switch self {
        case .getWeatherData:
            return "/data/2.5/weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeatherData:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getWeatherData(let name):
            var urlParameters = [String: Any]()
            urlParameters["q"] = name
            urlParameters["appid"] = apiKey
            urlParameters["lang"] = "ru"
            return .requestParameters(
                parameters: urlParameters,
                encoding: URLEncoding.queryString)
        }
    }
}

extension TargetType {
    
    var baseURL: URL { return URL(string: "https://api.openweathermap.org")! }

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json;charset=utf-8"]
    }

}
