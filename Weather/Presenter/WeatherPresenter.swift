import RxSwift

class WeatherPresenter: WeatherPresentation {
    
    weak var view: WeatherView?
    private let useCase: WeatherUseCase
    private let disposeBag = DisposeBag()
    
    init(view: WeatherView?, useCase: WeatherUseCase) {
        self.view = view
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        addCity(cityName: "Москва")
        addCity(cityName: "Калининград")
        subscribeOnWeatherCities()
    }
    
    private func subscribeOnWeatherCities() {
        useCase.subscribeOnWeatherDataCities()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.view?.setWeatherData(weatherData: data)
            })
            .disposed(by: disposeBag)
    }
    
    func addCity(cityName: String) {
        useCase.getWeatherData(cityName: cityName)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { _ in },
                       onError: { error in
                        print(error.localizedDescription) })
            .disposed(by: disposeBag)
    }
    
    func deleteCity(cityId: Int) {
        useCase.deleteCity(cityId)
    }
}
