import UIKit

struct WeatherScreens {
    
    private static let repository = WeatherRepository()
    private static let inMemoryRepository = InMemoryWeatherRepository()
    static let useCase: WeatherUseCase = WeatherInteractor(repository: repository, inMemoryRepository: inMemoryRepository)
    
    class MainScreen {
        
        func assembleScreen() -> UIViewController {
            let view = WeatherViewController()
            let presenter = WeatherPresenter(view: view, useCase: useCase)
            view.presenter = presenter
            return view
        }
    }
}
