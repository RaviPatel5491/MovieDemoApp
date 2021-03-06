//
//  MoviesCell.swift
//  MovieDemo
//
//  Created by Ravi on 05/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

// Custom TableView cell for Movie listing TableView

import UIKit
import Cosmos
class MoviesCell: UITableViewCell {
    
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var btnBuyTicket: UIButton!
    @IBOutlet weak var lblAgeRating: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieDesc: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var cosmoView: CosmosView!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgMoviePoster.layer.cornerRadius = 10
        self.imgMoviePoster.layer.masksToBounds = true
        
        self.btnBuyTicket.layer.cornerRadius = btnBuyTicket.frame.height/2
        
        self.lblAgeRating.layer.cornerRadius = lblAgeRating.frame.height/2
        self.lblAgeRating.layer.borderColor = UIColor.darkGray.cgColor
        self.lblAgeRating.layer.borderWidth = 1.0

        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
