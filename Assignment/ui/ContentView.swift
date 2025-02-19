//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//


import UIKit

class ContentViewController: UIViewController {
    
    private let viewModel = ContentViewModel()
    private var devices: [DeviceData] = []
    private var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DeviceCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        fetchData()
        
        navigationItem.title = "Computers"
        view.backgroundColor = .white
    }
    
    func fetchData() {
        activityIndicator.startAnimating()
       
        self.viewModel.fetchAPI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let data = self.viewModel.data {
                self.devices = data
                self.tableView.reloadData()
            }
            self.activityIndicator.stopAnimating() 
            self.tableView.isHidden = false
        }
    }
}

extension ContentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath)
        let device = devices[indexPath.row]
        cell.textLabel?.text = device.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDevice = devices[indexPath.row]
        _ = DetailViewController(device: selectedDevice)
    }
}





