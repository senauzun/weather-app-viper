//
//  Router.swift
//  weather-app-viper
//
//  Created by Sena Uzun on 26.11.2022.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
    
}

class WeatherRouter : AnyRouter {
    var entry : EntryPoint?
    static func startExecution() -> AnyRouter {
        let router = WeatherRouter()
        var view : AnyView = WeatherViewController()
        var presenter: AnyPresenter = WeatherPresenter()
        var interactor : AnyInteractor = WeatherInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
