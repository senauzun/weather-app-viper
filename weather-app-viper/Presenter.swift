//
//  Presenter.swift
//  weather-app-viper
//
//  Created by Sena Uzun on 26.11.2022.
//
 
import Foundation


enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}

    func interactorDidDowloadWeathers(result : Result<[Wheather],Error>)
}

class WeatherPresenter : AnyPresenter {
    
    var interactor: AnyInteractor?{
        didSet {
            interactor?.dowloadWeathers()
        }
    }
    
    var router: AnyRouter?
    
    
    var view: AnyView?
    
    func interactorDidDowloadWeathers(result: Result<[Wheather],Error>) {
        switch result {
        case.success(let pharms):
            view?.update(with: pharms)
        case.failure(_):
            view?.update(with: "Try later")
        }
    }
}
