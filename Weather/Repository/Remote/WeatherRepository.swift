import Foundation
import RxSwift
import Moya
import ObjectMapper

class WeatherRepository {
    
    private let provider = MoyaProvider<WeatherApiService>()
    
    func getWeatherData(name: String) -> Single<WeatherData> {
        return provider.rx.request(.getWeatherData(name: name))
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .mapObject(type: RestWeatherData.self)
            .map {  $0.toEntity() }
    }
}
