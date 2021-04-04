import RxSwift

class InMemoryWeatherRepository {
    
    private var weatherDataCities = [WeatherData]()
    private let subjectWeatherDataСities = PublishSubject<[WeatherData]>.init()
    
    func getWeatherDataСities() -> Observable<[WeatherData]> {
        subjectWeatherDataСities.asObserver()
    }
    
    func deleteWeatherDataСity(_ id: Int) {
        let index = weatherDataCities.firstIndex(where: { $0.id == id })
        if let indexCity = index {
            weatherDataCities.remove(at: indexCity)
        }
        subjectWeatherDataСities.onNext(weatherDataCities)
    }
    
    func addWeatherDataСity(_ weatherCity: WeatherData) -> Completable {
        weatherDataCities.append(weatherCity)
        subjectWeatherDataСities.onNext(weatherDataCities)
        return Completable.empty()
    }
}
