//
//  NewsItemTableViewCell.swift
//  NewsApp
//
//  Created by Muhammadjon Loves on 7/6/22.
//

import UIKit

class NewsItemTableViewCellViewModel {
    let title: String
    let description: String
    let imageURL : String
    
    init (title: String, description: String, imageURL: String) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
}

class NewsItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
//        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel:NewsItemTableViewCellViewModel ) {
        headLineLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        
        // Prosses Image
        if let url = URL(string: (viewModel.imageURL)) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    self.newsImage.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
}


