//
//  LaunchDetailViewController.swift
//  SpaceXLiveLaunch
//
//  Created by Dan Danilescu on 11/21/20.
//  Copyright © 2020 Dan Danilescu. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class LaunchDetailViewController: UIViewController {

    @IBOutlet weak var youtubeView: YTPlayerView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var payloadMassLabel: UILabel!
    
    let networkObject = NetworkManager("https://api.spacexdata.com/v4/")
    var rocket: RocketModel?
    var launch: LaunchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkObject.performRequest(endpoint: .rockets) { [weak self] (result: Result<RocketModel, Error>) in
            guard self != nil else { return }
                
                switch result {
                case .success(let rocket):
                    self?.rocket = rocket
                    print(rocket)
                    break
                    
                case .failure(let error):
                    print(error)
                }
            }
        
        guard let launch = launch else { return }
        guard let youtubeLink = launch.links?.youtube_id else { return }
        youtubeView.load(withVideoId: youtubeLink)
        
        guard let unixDate = launch.date else { return }
        let date = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT +2")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let strDate = dateFormatter.string(from: date)
        dateLabel.text = strDate
        descriptionLabel.text = launch.details
        
    }
    
    @IBAction func wikipediaButtonPressed(_ sender: Any) {
        if let url = launch?.links?.wikipedia {
            UIApplication.shared.open(url)
        }
    }
}
