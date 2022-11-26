//
//  Interactor.swift
//  weather-app-viper
//
//  Created by Sena Uzun on 26.11.2022.
//

import Foundation

protocol AnyInteractor {
    var presenter : AnyPresenter? {get set}
    func dowloadWeathers()
}


class WeatherInteractor : AnyInteractor {
    var presenter : AnyPresenter?

    func dowloadWeathers() {
            guard let url = URL(string:"https://raw.githubusercontent.com/senauzun/weather-app-viper/main/weatherlist.json")
                    
            else{
                return
            }

            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data , error == nil else{
                    self?.presenter?.interactorDidDowloadWeathers(result: .failure(NetworkError.NetworkFailed))
                    return
                }

                do {
                    let weathers = try JSONDecoder().decode([Wheather].self, from: data)
                    self?.presenter?.interactorDidDowloadWeathers(result: .success(weathers))
                }catch{
                    self?.presenter?.interactorDidDowloadWeathers(result: .failure(NetworkError.ParsingFailed))
                }
            }
            task.resume()
                    
        
    }
    
    

    
    
}
