//
//  SelectLocationViewController.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/8/22.
//

import Foundation
import UIKit
import GooglePlaces

class SelectLocationViewController : UIViewController, UITableViewDelegate {
    var fetcher: GMSAutocompleteFetcher?
    var placeResults : [Place] = [Place]()
    var placesClient : GMSPlacesClient = GMSPlacesClient.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        //        filter.locationBias = GMSPlacesAutocompleteTypeFilter.region
        let sessionToken = GMSAutocompleteSessionToken.init()
        
        
        fetcher = GMSAutocompleteFetcher(filter: filter)
        fetcher?.delegate = self
        fetcher?.provide(sessionToken)
        
        searchField.addTarget(self, action: #selector(textFieldDidChange(textField:)),
                              for: .editingChanged)
        
        // Table View Setup
        resultTableView.dataSource = self
        resultTableView.delegate = self
        
        view.addSubview(containerView)
        containerView.addSubview(searchField)
        containerView.addSubview(resultTableView)
        
        placeResults = Place.createDebugPlaces()
    }
    
    
    override func viewWillLayoutSubviews() {
        let displayWidth = self.view.frame.width
        let displayHeight = self.view.frame.height
        
        let sidePadding = 10.0
        
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: sidePadding, paddingBottom: 0, paddingRight: sidePadding, width: displayWidth, height: displayHeight/2, enableInsets: false)
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        searchField.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 50, enableInsets: false)
        
        resultTableView.anchor(top: searchField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: view.frame.height, enableInsets: false)
    }
    
    private let containerView : UIView = {
        let view = UIView()
        return view
    }()
    
    private let resultTableView : UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PlaceCell.self, forCellReuseIdentifier: "PlaceCell")
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let searchField : TarrareUITextField = {
        let field = TarrareUITextField()
        field.setImage(image: UIImage(systemName: "magnifyingglass")!)
        field.autocorrectionType = .no
        field.attributedPlaceholder = NSAttributedString(string: "Search for a building on campus", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return field
    }()
    
    @objc func textFieldDidChange(textField: UITextField) {
        fetcher?.sourceTextHasChanged(textField.text!)
    }
}


extension SelectLocationViewController: GMSAutocompleteFetcherDelegate {
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        self.placeResults = predictions.map { Place($0) }
        self.resultTableView.reloadData()
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print("Failed to autocomplete: \(error.localizedDescription)")
    }
    
}

extension SelectLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
        let currentPlace = placeResults[indexPath.row]
        cell.place = currentPlace
        return cell
        
    }
}
