import UIKit
import PureLayout

class WeatherViewCell: UITableViewCell {
    
    private lazy var imgView: UIImageView = {
        let logoImgView = UIImageView()
        logoImgView.autoSetDimensions(to: CGSize(width: 48, height: 48))
        return logoImgView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        return label
    }()
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(imgView)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        tempLabel.autoPinEdge(.left, to: .right, of: titleLabel, withOffset: 16)
        tempLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        imgView.autoPinEdge(.left, to: .right, of: tempLabel, withOffset: 8)
        imgView.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        imgView.autoAlignAxis(toSuperviewAxis: .horizontal)
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 8)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(title: String, weather: Weather, main: MainInfo) {
        titleLabel.text = title
        tempLabel.text = convertTemp(temp: main.temp, from: .kelvin, to: .celsius)
        descriptionLabel.text = weather.description
        if let image = UIImage(named: weather.icon) {
            imgView.image = image
        } else {
            imgView.image = UIImage(named: "placeholder")
        }
    }
    
    private func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return mf.string(from: output)
     }
    
}
