//
//  ComingSoonMoviesVC.swift
//  MovieDemo
//
//  Created by Ravi on 05/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit

class ComingSoonMoviesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - iPhone Life Cycle
    
    @IBOutlet weak var tblMovies: UITableView!
    var pageNo = 0
    var keyword = ""

    var comingsoonVM = ComingsoonViewModel() {
        didSet {
            comingsoonVM.arrMovies.bind = { [unowned self] in self.arrMovies = $0 }
            comingsoonVM.keyword.bind = { [unowned self] in self.keyword = $0 }
        }
    }
    var arrMovies = [Movies]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getNowShowing()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    // MARK: - Helping Mehods
    
    func getNowShowing()
    {
        comingsoonVM.loadComingSoon(page: "\(pageNo)", completionHandler: { success , movies in
            self.arrMovies.append(contentsOf: movies)
            self.tblMovies.reloadData()
            self.tblMovies.tableFooterView?.isHidden = true
        })
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    //    {
    //        return UITableViewAutomaticDimension
    //
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let objMoviesCell:MoviesCell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        
        objMoviesCell.selectionStyle = .none
        
        let objMovie = arrMovies[indexPath.row]
        objMoviesCell.lblMovieName.text = objMovie.title
        
        // url
        let urlString = arrMovies[indexPath.row].poster_path!
        let url = URL(string: urlString)
        objMoviesCell.imgMoviePoster?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
        
        objMoviesCell.lblMovieDesc.text = objMovie.description
        objMoviesCell.lblAgeRating.text = objMovie.age_category
        
        let rating = objMovie.rate!/2
        objMoviesCell.cosmoView.rating = rating
        objMoviesCell.cosmoView.text = String(format: "%.2f", rating)
        var date = Date(milliseconds: objMovie.release_date!)
        objMoviesCell.lblReleaseDate.text = date.getReleasDate()
        
        // for animation
        if indexPath.section ==  0 && indexPath.row == arrMovies.count - 1 && (tableView.indexPathsForVisibleRows?.contains(indexPath))!  {
            // print("this is the last cell")
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            self.pageNo += 1
            getNowShowing()
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
        
        return objMoviesCell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
