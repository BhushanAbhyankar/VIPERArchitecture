//
//  Interactor.swift
//  VIPERArchitecture
//
//  Created by Bhushan Abhyankar on 26/01/2023.
//

import Foundation

protocol AnyInteractor{
    var presenter: AnyPresenter? {get set}
    
    func getEmployess()
}

class EmployeeInteractor:AnyInteractor, NetworkMangerDelegate{
    func didFinishLoadingData(data: Data) async {
        do{
            let welcome = try JSONDecoder().decode(ProductData.self, from: data)
            presenter?.intreactorDidFinishEmployes(with: .success(welcome.products))
        }catch let error {
            print(error.localizedDescription)
            presenter?.intreactorDidFinishEmployes(with: .failure(NetworkError.parsingError))
        }
    }
    
    func didFinishWithError(error: Error) async {
        presenter?.intreactorDidFinishEmployes(with: .failure(NetworkError.dataNotFound))

    }
    
    var presenter: AnyPresenter?
    
    func getEmployess() {
        Task{
            do{
                let networkManager = NetworkManger()
                networkManager.delegate = self
                let url = URL(string: "https://dummyjson.com/products")!
                try await networkManager.getDataFromAPI(url: url)
                
            }catch{
            }
        }
    }
    
    
}
