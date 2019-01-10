//
//  HomeMovieVC.swift
//  MovieDemo
//
//  Created by Jigar Patel on 09/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FSPagerView
class buttonRound: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
    }
}
class HomeMovieVC: UIViewController,UICollectionViewDelegate,UIScrollViewDelegate, UICollectionViewDelegateFlowLayout{
    // MARK: - Declaration

    //properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitleMovie: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    
    //collectionview setup properties
    var collectionMargin = CGFloat(60)
    let itemSpacing = CGFloat(20)
    let itemHeight = CGFloat(322)
    var itemWidth = CGFloat(0)
    var currentItem = 0
    var isPageMoving = false
    var timerStarted = false
    var disposeBag = DisposeBag()
    var homeVM = HomeViewModel()
    var timerPage = Timer()

    // MARK: - iPhone Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createNavigation()
        setup()
        bindCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: - Helping methods
    
    //setup collectionview
    func setup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //itemWidth =  UIScreen.main.bounds.width - collectionMargin * 2.0
        itemWidth = collectionView.frame.width * 0.6
        collectionMargin =  (UIScreen.main.bounds.width - itemWidth)/2
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        
        UIApplication.shared.statusBarStyle = .lightContent

    }
    
    //timer to auto update
    func startTimer()
    {
        if !timerPage.isValid
        {
            timerPage = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateToNewPage), userInfo: nil, repeats: true)
        }
    }
    
    // called after 5 second of page display
    func updateToNewPage()
    {
        if homeVM.arrMovies.value.count == 0
        {
            return
        }
        lastIndexCollection = indexCollection
        if indexCollection ==  homeVM.arrMovies.value.count - 1
        {
            indexCollection = 0
        }
        else
        {
            indexCollection += 1
        }
        
        let indexPath = IndexPath(row: indexCollection, section: 0)
        updatePages()
        self.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.showPageComonents()
    }
    //create navigationbar
    func createNavigation()
    {
        self.title = "Movie"
        self.navigationController?.isNavigationBarHidden = false
        
        //        self.navigationController?.navigationBar.isTranslucent = false
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
    func bindCollectionView()
    {
        self.collectionView.isHidden = true
        homeVM.arrMovies.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "PagerCollectionCell"))(setupCell)
            .addDisposableTo(disposeBag)
        startTimer()
    }
    
    private func setupCell(row: Int,objMovie:Movies, cell: UICollectionViewCell)
    {
        if !timerStarted
        {
            timerStarted = true
            self.startTimer()
        }
        self.collectionView.isHidden = false

        let objMovieCell = cell as! PagerCollectionCell
        
        let urlString = objMovie.poster_path!
        let url = URL(string: urlString)
        objMovieCell.imageMovie?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
        objMovieCell.contentMode = .scaleAspectFill
        objMovieCell.imageMovie?.clipsToBounds = true
        
        objMovieCell.lblPreSale?.isHidden = objMovie.presale_flag! == 1 ? false : true
        if isPageMoving
        {
            objMovieCell.btnBuy?.isHidden = true
            objMovieCell.lblPreSale?.isHidden = true
        }
        else if row == indexCollection
        {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: [], animations: {
                objMovieCell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            })
            UIView.animate(withDuration: 0.6,
                           animations: {
                            objMovieCell.btnBuy?.isHidden = false
                            objMovieCell.btnBuy?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
                           completion: { _ in
                            UIView.animate(withDuration: 0.6) {
                                objMovieCell.btnBuy?.transform = CGAffineTransform.identity
                            }
            })
        }
        else
        {
            objMovieCell.btnBuy?.isHidden = true
            objMovieCell.lblPreSale?.isHidden = true
        }
    }
    func hidePageComponents()
    {
        lblTitleMovie.fadeOut()
        lblGenre.fadeOut()
        
        ///// reload collection view
        isPageMoving = true
        let indexPath = IndexPath(row: indexCollection, section: 0)
        collectionView.reloadItems(at: [indexPath])
    }
    func showPageComonents()
    {
        guard indexCollection <  homeVM.arrMovies.value.count   else {
            return
        }
        // animations
        lblTitleMovie.fadeOut()
        lblGenre.fadeOut()
        
        lblTitleMovie.fadeIn()
        lblGenre.fadeIn()
        
        //title
        let objMovie  = homeVM.arrMovies.value[indexCollection]
        
        lblTitleMovie.text = objMovie.title
        lblGenre.text = objMovie.genre_name
        
        
        ///// reload collection view
        isPageMoving = false
        updatePages()
        
    }
    func updatePages()
    {
        let indexPath = IndexPath(row: indexCollection, section: 0)
        let indexPathLast = IndexPath(row: lastIndexCollection, section: 0)
        collectionView.reloadItems(at: [indexPath,indexPathLast])
    }
    // MARK: - UIScrollViewDelegate protocol
    var indexCollection = 0
    var lastIndexCollection = 0

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //timer invalidate when scroll
        timerPage.invalidate()
        hidePageComponents()
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width  )
        var newPage = Float(indexCollection)
        //
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? indexCollection + 1 :indexCollection - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        //start timer again
        self.startTimer()
        
        if Int(newPage) >  homeVM.arrMovies.value.count - 1
        {
            newPage = newPage - 1
        }
        else if indexCollection != Int(newPage)
        {
            lastIndexCollection = indexCollection
        }
        indexCollection = Int(newPage)
        //self.pageControl.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat( Float(indexCollection) * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
        
        //
        showPageComonents()
    }
    
}
