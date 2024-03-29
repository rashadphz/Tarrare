//
//  OrderScreenRestaurantsViewController.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/27/22.
//

import UIKit
import Foundation
import CoreLocation

class OrderScreenRestaurantsViewController: UIViewController, UITableViewDelegate {
    var arrayOfRestaurants : [Resturant] = [Resturant]()
    var currentPlace : Place? = Place.userCurrent {
        didSet {
            Place.userCurrent = currentPlace
            if let place = currentPlace {
                self.currentLocationLabel.text = place.name
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRestaurants()
        addCurrentLocationLabelGesture()
        setupNavbar()
        
        view.backgroundColor = .white
        restaurantTableView.dataSource = self
        restaurantTableView.delegate = self
        
        view.addSubview(containerView)
        containerView.addSubview(restaurantTableView)
        
        restaurantTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshRestaurantData(_:)), for: .valueChanged)
    
        containerView.addSubview(tableInfoStackView)
        tableInfoStackView.addArrangedSubview(currentRestaurantsLabel)
        
    }
    
    func setupNavbar() {
        APIManager.shared().getCurrentPlace(completion: {place in
            self.currentPlace = place
        })

       self.navigationController?.navigationBar.isTranslucent = true
       self.navigationController?.navigationBar.backgroundColor = UIColor.white
       self.navigationController?.navigationBar.shadowImage = UIImage()
       
       let stackView = UIStackView(arrangedSubviews: [currentLocationLabel])
       navigationItem.titleView = stackView
    }
    
    override func viewWillLayoutSubviews() {
        let displayWidth = self.view.frame.width
        let displayHeight = self.view.frame.height
        
        let sidePadding = 20.0
        
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: sidePadding, paddingBottom: 0, paddingRight: sidePadding, width: displayWidth, height: displayHeight, enableInsets: false)
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        tableInfoStackView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 50, enableInsets: false)
        
        currentRestaurantsLabel.anchor(top: tableInfoStackView.topAnchor, left: tableInfoStackView.leftAnchor, bottom: tableInfoStackView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        restaurantTableView.anchor(top: tableInfoStackView.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: containerView.frame.width, height: containerView.frame.height, enableInsets: false)
    }
    
    private let refreshControl = UIRefreshControl()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let currentLocationLabel: LocationUILabel = {
        let label = LocationUILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let tableInfoStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 3
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let currentRestaurantsLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Semibold", size: 22)
        label.textColor = .black
        label.text = "Current Restaurants"
        return label
    }()
    
    private let restaurantTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.layer.masksToBounds = true
        tableView.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        tableView.layer.cornerRadius = 10
        
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: "RestaurantCell")
        return tableView
    }()
    
    
    @objc private func refreshRestaurantData(_ sender: Any) {
        fetchRestaurants()
    }
    
    func fetchRestaurants() {
        Resturant.getAllActiveRestaurants(completion: {restaurants in
            if let restaurants = restaurants {
                self.arrayOfRestaurants = restaurants
                self.refreshControl.endRefreshing()
                self.restaurantTableView.reloadData()
            }
        })
    }
    
    func presentDeliverersForRestaurant(restaurant: Resturant) {
        let restaurantDeliveriesVC = RestaurantDeliveriesViewController()
        restaurantDeliveriesVC.restaurant = restaurant
        self.navigationController?.show(restaurantDeliveriesVC, sender: nil)
    }
    
    // MARK: Gestures/Actions
    func addCurrentLocationLabelGesture() {
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCurrentLocationLabel))
        currentLocationLabel.isUserInteractionEnabled = true
        currentLocationLabel.addGestureRecognizer(labelTapGesture)
    }
    
    @objc func didTapCurrentLocationLabel() {
        let selectLocationVC = SelectLocationViewController()
        selectLocationVC.delegate = self
        self.present(selectLocationVC, animated: true)
    }
}

extension OrderScreenRestaurantsViewController : SelectLocationViewDelegate {
    func sendSelectedPlace(place: Place) {
        self.currentPlace = place
    }
}

extension OrderScreenRestaurantsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        let currentRestaurant = arrayOfRestaurants[indexPath.row]
        cell.restaurant = currentRestaurant
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRestaurant = arrayOfRestaurants[indexPath.row]
        self.presentDeliverersForRestaurant(restaurant: selectedRestaurant)
    }
}


