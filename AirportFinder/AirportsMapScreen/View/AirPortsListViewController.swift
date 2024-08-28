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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = annotationsInfo[indexPath.row].title
        content.secondaryText = annotationsInfo[indexPath.row].subtitle
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annotationsInfo.count
    }
}
