//
//  LaunchTableViewCell.swift
//  SpaceXLiveLaunch
//
//  Created by Dan Danilescu on 11/23/20.
//  Copyright © 2020 Dan Danilescu. All rights reserved.
//

import UIKit
import Kingfisher

class LaunchTableViewCell: UITableViewCell {

    @IBOutlet weak var launchImage: UIImageView!
    @IBOutlet weak var launchNameLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cofigureCell(with viewModel: LaunchModel) {
//        guard let name = viewModel.name else { return }
        launchNameLabel.text = viewModel.name
        
        guard let unixDate = viewModel.date else { return }
        let date = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT +2")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let strDate = dateFormatter.string(from: date)
        launchDateLabel.text = strDate
        
        let url = viewModel.links?.patch.large
        let processor = DownsamplingImageProcessor(size: launchImage.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        launchImage.kf.indicatorType = .activity
        launchImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
