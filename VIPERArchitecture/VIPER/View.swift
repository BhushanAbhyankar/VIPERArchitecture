//
//  View.swift
//  VIPERArchitecture
//
//  Created by Bhushan Abhyankar on 26/01/2023.
//

import Foundation
protocol AnyView{
    var presenter:AnyPresenter?{get set}
    
    func update(with employes:[Product])
    func update(with error:String)
}


