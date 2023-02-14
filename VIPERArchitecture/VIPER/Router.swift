//
//  Router.swift
//  VIPERArchitecture
//
//  Created by Bhushan Abhyankar on 26/01/2023.
//

import Foundation
import UIKit

typealias EntryPoint = UIViewController & AnyView

protocol AnyRouter{
    var entry:EntryPoint? {get}
    static func start() -> AnyRouter
    func moveToDetails(withData: Product)

}

class EmployeeRouter: AnyRouter{
    
    func moveToDetails(withData: Product) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let  detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsViewController.data = withData
        entry?.navigationController?.pushViewController(detailsViewController, animated: true)
//        entry?.present(detailsViewController, animated: true)
    }
    
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = EmployeeRouter()
        
        //assign VIP
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let  myViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController

        var view: AnyView = myViewController //ViewController()
        var interactor : AnyInteractor = EmployeeInteractor()
        var presenter : AnyPresenter = EmployeePresenter()

        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.intreactor = interactor
        
        router.entry = view as? EntryPoint
        return router
    }
    
    
}
