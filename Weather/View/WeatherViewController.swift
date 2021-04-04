import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherTableView: UITableView!
    
    private var weatherData: [WeatherData] = []
    
    var presenter: WeatherPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTableView.register(WeatherViewCell.self, forCellReuseIdentifier: String(describing: WeatherViewCell.self))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.title = "Погода"
        presenter.viewDidLoad()
    }
    
    @objc func addTapped() {
        let alert = UIAlertController(title: "Добавить город", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Введите название"
        })
        let alertActionAdd = UIAlertAction(title: "Добавить", style: .default, handler: { [weak self] alertAction in
            if let text = alert.textFields?.first?.text, text != "" {
                self?.presenter.addCity(cityName: text)
            }
        })
        let alertActionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in })
        alert.addAction(alertActionAdd)
        alert.addAction(alertActionCancel)
        self.present(alert, animated: false, completion: nil)
    }
    
}

extension WeatherViewController: WeatherView {
    
    func setWeatherData(weatherData: [WeatherData]) {
        self.weatherData = weatherData
        weatherTableView.reloadData()
    }

}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherViewCell.self), for: indexPath) as! WeatherViewCell
        cell.isSelected = false
        let data = weatherData[indexPath.row]
        cell.bind(title: data.name, weather: data.weather[0], main: data.mainInfo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Удал.") { action, index in
            self.presenter.deleteCity(cityId: self.weatherData[indexPath.row].id)
        }
        delete.backgroundColor = .red
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
