//
//  LaunchListTableViewController.swift
//  SpaceXLiveLaunch
//
//  Created by Dan Danilescu on 11/21/20.
//  Copyright © 2020 Dan Danilescu. All rights reserved.
//

import UIKit

class LaunchListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let networkObject = NetworkManager("https://api.spacexdata.com/v4/")
    var launches = [LaunchModel]()
    let cellIdentifier = String(describing: LaunchTableViewCell.self)
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: width, height: height))

        tableView.register(UINib.init(nibName: "LaunchTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
          
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        networkObject.performRequest(endpoint: .launches) { [weak self] (result: Result<[LaunchModel], Error>) in
            guard self != nil else { return }
                
                switch result {
                
                case .success(let launches):
                    for launch in launches {
                        self?.launches.append(launch)
                           }
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    print(launches)
                    break
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func updateModel(_ launches : [LaunchModel]){
        for launch in launches {
            self.launches.append(launch)
        }
     }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LaunchTableViewCell

        cell.cofigureCell(with: launches[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "detailsViewController") as! LaunchDetailViewController
        detailsViewController.launch = launches[indexPath.row]
        self.present(detailsViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
