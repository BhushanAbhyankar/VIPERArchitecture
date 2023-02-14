//
//  Presenter.swift
//  VIPERArchitecture
//
//  Created by Bhushan Abhyankar on 26/01/2023.
//

import Foundation
protocol AnyPresenter{
    var router: AnyRouter? {get set}
    var intreactor: AnyInteractor? {get set}
    var view: AnyView? {get set}

    func intreactorDidFinishEmployes(with result:Result<[Product],Error>)
    func showDetails(withData: Product)
}

class EmployeePresenter:AnyPresenter{
    func showDetails(withData data: Product) {
        router?.moveToDetails(withData: data)
    }
    
   
    var router: AnyRouter?
    
    var intreactor: AnyInteractor?{
        didSet{
            intreactor?.getEmployess()
        }
    }
    
    var view: AnyView?
    
    func intreactorDidFinishEmployes(with result: Result<[Product], Error>) {
        switch result{
        case .success(let employes):
            print(employes)
            view?.update(with: employes)
        case.failure(let error):
            print(error )
            view?.update(with: "something went Wrong")

        }
    }
    
}
