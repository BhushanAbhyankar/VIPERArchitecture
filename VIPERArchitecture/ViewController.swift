//
//  ViewController.swift
//  VIPERArchitecture
//
//  Created by Bhushan Abhyankar on 26/01/2023.
//
///VIPER
///VIPER - View, Interactor, Presenter, Entity, and Router.
///View: The responsibility of the view is to send the user actions to the presenter and shows whatever the presenter tells it.
///Interactor: This is the backbone of an application as it contains the business logic.
///Presenter: Its responsibility is to get the data from the interactor on user actions and after getting data from the interactor, it sends it to the view to show it. It also asks the router/wireframe for navigation.
///Entity: It contains basic model objects used by the Interactor.
///Router: It has all navigation logic for describing which screens are to be shown when. It is normally written as a wireframe.


import UIKit

class ViewController: UIViewController,AnyView {

    var presenter: AnyPresenter?
    var employess = [Product]()
    
    @IBOutlet weak var myTabelView: UITableView!
    //    private let tabelView:UITableView = {
//        let tabelView = UITableView()
//        tabelView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tabelView.isHidden = true
//        return tabelView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myTabelView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.myTabelView.isHidden = true
//        view.addSubview(tabelView)
//        tabelView.dataSource = self
//        tabelView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tabelView.frame = view.bounds
    }
    
    func update(with employes: [Product]) {
        DispatchQueue.main.async { [weak self] in
            self?.employess = employes
            self?.myTabelView.isHidden = false
            self?.myTabelView.reloadData()
        }
    }
    
    func update(with error: String) {
        print(error.description)
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showDetails(withData: employess[indexPath.row])
    }
}
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employess.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = employess[indexPath.row].title
        return cell
    }
}
