import RxSwift

class WeatherInteractor: WeatherUseCase {
    
    private let repository: WeatherRepository
    private let inMemoryRepository: InMemoryWeatherRepository
    
    init(repository: WeatherRepository, inMemoryRepository: InMemoryWeatherRepository) {
        self.repository = repository
        self.inMemoryRepository = inMemoryRepository
    }
    
    func getWeatherData(cityName: String) -> Single<WeatherData> {
        return repository.getWeatherData(name: cityName)
            .flatMap { data in
                return self.inMemoryRepository.addWeatherDataСity(data)
                    .andThen(Single.just(data))
            }
    }
    
    func subscribeOnWeatherDataCities() -> Observable<[WeatherData]> {
        inMemoryRepository.getWeatherDataСities()
    }
    
    func deleteCity(_ id: Int) {
        inMemoryRepository.deleteWeatherDataСity(id)
    }
}
