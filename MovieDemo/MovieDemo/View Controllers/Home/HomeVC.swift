//
//  HomeVC.swift
//  MovieDemop
//
//  Created by Jigar Patel on 05/01/19.
//  Copyright © 2019 BrainyBeam. All rights reserved.
//

import UIKit
import FSPagerView
import SDWebImage

class buttonRound: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
    }
}
class HomeVC: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {
    // MARK:- Declaration
    @IBOutlet weak var btn_buyTickets: UIButton!
    @IBOutlet weak var lblTitleMovie: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblPreSale: UILabel!
    
    var arrMovies = [Movies]()
    var homeVM: HomeViewModel!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "PagerCell")
            pagerView.transformer = FSPagerViewTransformer(type: .linear)
            self.pagerView.automaticSlidingInterval = 4.0 - self.pagerView.automaticSlidingInterval
            self.pagerView.delegate = self
            self.pagerView.dataSource = self
            
            self.pagerView.itemSize = CGSize(width: 250, height: 350)
            pagerView.reloadData()
            
        }
    }
    
    // MARK:- iPhone Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagerView.bringSubview(toFront: btn_buyTickets)
        pagerView.bringSubview(toFront: lblPreSale)
        createNavigationBar()
        UIApplication.shared.statusBarStyle = .lightContent
        setNeedsStatusBarAppearanceUpdate()
        setNeedsStatusBarAppearanceUpdate()
        getHomeScreen()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK:- Helping Methods
    func getHomeScreen()
    {
        view.isHidden = true
        homeVM = HomeViewModel()
        homeVM.fetchHomeData{ success , arrMovies in
            if success
            {
                self.view.isHidden = false
                self.arrMovies = arrMovies
                self.pagerView.reloadData()
                self.showPageComonents()
            }
            else
            {
                AppUtility.alertWithTitle("", Message: SOMETHING_WENT_WRONG, Cancelbtn: "Ok", otherbutton: "")
            }
        }
    }
    func createNavigationBar()
    {
        self.title = "Movie"
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = colorPrimary
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let btnSearch = UIBarButtonItem(image: UIImage(named: "Ic_Search"), style: .plain, target: self, action: #selector(self.btnSearchClicked))
        self.navigationItem.rightBarButtonItem  = btnSearch
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    func btnSearchClicked()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    func showPageComonents()
    {
        // animations
        btn_buyTickets.fadeIn()
        lblTitleMovie.fadeIn()
        lblGenre.fadeIn()

        //title
        let objMovie  = arrMovies[pagerView.currentIndex]
        if objMovie.presale_flag == 1
        {
            lblPreSale.fadeIn()
        }
        lblTitleMovie.text = objMovie.title
        lblGenre.text = objMovie.genre_name
    }
    func hidePageComponents()
    {
        btn_buyTickets.fadeOut()
        lblTitleMovie.fadeOut()
        lblGenre.fadeOut()
        lblPreSale.fadeOut()
    }
    // MARK:- FSPagerViewDelegate
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        let isPageScrolled = floor(pagerView.scrollOffset) == pagerView.scrollOffset // true
        
        if isPageScrolled
        {
            showPageComonents()
        }
        else
        {
            hidePageComponents()
        }
    }
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.arrMovies.count
    }
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PagerCell", at: index)
        cell.imageView?.contentMode = .scaleAspectFill
        
        let urlString = arrMovies[index].poster_path!
        let url = URL(string: urlString)
        cell.imageView?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
        self.pagerView.bringSubview(toFront: btn_buyTickets)
        
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int) {
    }
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int)
    {
        
    }
    
    
    
    
}
