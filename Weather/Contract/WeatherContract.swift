import RxSwift

protocol WeatherUseCase: class {
    
    func getWeatherData(cityName: String) -> Single<WeatherData>
    
    func subscribeOnWeatherDataCities() -> Observable<[WeatherData]>
    
    func deleteCity(_ id: Int)
}

protocol WeatherPresentation: class {
    
    func viewDidLoad()
    
    func addCity(cityName: String)
    
    func deleteCity(cityId: Int)
}

protocol WeatherView: class {
    
    func setWeatherData(weatherData: [WeatherData])
}
