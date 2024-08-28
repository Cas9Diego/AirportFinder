//
//  AirPortsListViewController.swift
//  AirportFinder
//
//  Created by Diego Castro on 27/08/24.
//

import UIKit
import MapKit

class AirPortsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ListViewProtocol {
    
    @IBOutlet var tableView: UITableView!
    var presenter: AirportsPresenterProtocol?
    var annotationsInfo: [MKPointAnnotation] = []
    var didfetchData: Bool = false
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setupActivityIndicator()
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if didfetchData {
            stopAnimating()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = annotationsInfo[indexPath.row].title
        content.secondaryText = annotationsInfo[indexPath.row].subtitle
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annotationsInfo.count
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
