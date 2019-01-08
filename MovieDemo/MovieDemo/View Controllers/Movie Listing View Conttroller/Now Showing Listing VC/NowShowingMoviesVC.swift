//
//  NowShowingMoviesVC.swift
//  MovieDemo
//
//  Created by Ravi on 05/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NowShowingMoviesVC: UIViewController {
    
    // MARK: - iPhone Life Cycle

    @IBOutlet weak var tblMovies: UITableView!
    var pageNo = 0
    var keyword = ""

    var nowShowingVM = NowShowingViewModel()
    var disposeBag = DisposeBag()

    var arrMovies = [Movies]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMovies.contentInset = UIEdgeInsets.zero
        getNowShowing()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {

    }
    // MARK: - Helping Mehods
    
    func getNowShowing()
    {
        nowShowingVM.arrMovies.asObservable().bind(to: tblMovies.rx.items(cellIdentifier: "MoviesCell"))(setupCell).addDisposableTo(disposeBag)
    }

    // MARK: - TableView Methods
    private func setupCell(row: Int,objMovie:Movies, cell: UITableViewCell){
        
        let objMoviesCell = cell as! MoviesCell
        objMoviesCell.selectionStyle = .none
        
        objMoviesCell.lblMovieName.text = objMovie.title
        
        // url
        
        let urlString = objMovie.poster_path!
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
        let indexPath = IndexPath(row: row, section: 0)
        
        if  row == nowShowingVM.arrMovies.value.count - 1 && (tblMovies.indexPathsForVisibleRows?.contains(indexPath))!  {
            // print("this is the last cell")
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tblMovies.bounds.width, height: CGFloat(44))
            self.pageNo += 1
            nowShowingVM.loadNowShowing(page: "\(pageNo)")
            tblMovies.tableFooterView = spinner
            tblMovies.tableFooterView?.isHidden = false
        }
        
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
