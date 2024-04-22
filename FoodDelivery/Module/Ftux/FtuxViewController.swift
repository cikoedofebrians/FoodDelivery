//
//  FtuxViewController.swift
//  FoodDelivery
//
//  Created by Ciko Edo Febrian on 04/03/24.
//

import UIKit

class FtuxViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = FtuxViewModel()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        observeError()
        observeCurrentIndex()
        viewModel.loadFtuxes()
    }
    
    func observeError() {
        viewModel.error.bind { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    func observeCurrentIndex() {
        viewModel.currentIndex.bind { [weak self] index in
            guard let self = self else { return }
            switch index {
            case -1:
                break
            default:
                activityIndicator.stopAnimating()
                if (index == 0){
                    self.collectionView.reloadData()
                }
                
                self.goToPage(page: index)
            }
            
        }
    }
    
    //MARK: - HELPER
    
    func setup() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        nextButton.layer.cornerRadius = 28
        nextButton.clipsToBounds = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    

    
    func updateCurrentPage(page: Int) {
        pageController.currentPage = page
        nextButton.setTitle(pageController.currentPage == (viewModel.numberOfItems - 1) ? "Let's start" : "Next", for: .normal)
    }
    
    func goToPage(page: Int) {
        collectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .centeredHorizontally, animated: true)
        updateCurrentPage(page: page)
    }
    
    
    //MARK: - ACTIONS
    
    @IBAction func tapNextButton(_ sender: Any) {
        let toPage = pageController.currentPage + 1
        print(self.viewModel.numberOfItems > 0)
        if (toPage < viewModel.numberOfItems) {
            self.viewModel.currentIndex.value = toPage
        } else if (self.viewModel.numberOfItems > 0){
            self.showLoginLandingViewController()
        }

        
    }
}
            
//MARK: - UICollectionViewDataSource
            
extension FtuxViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ftuxCellId", for: indexPath) as! FtuxViewCell
        
        let ftux = viewModel.ftuxes[indexPath.row]
        cell.imageView.image = UIImage(named: ftux.image)
        cell.titleLabel.text = ftux.title
        cell.subtitleLabel.text = ftux.subtitle
        return cell
    }
}

//MARK: - UICollectionViewDelegate
            
extension FtuxViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentNewPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        updateCurrentPage(page: currentNewPage)
    }
    
}
            
//MARK: - UICollectionViewDelegateFlowLayout

extension FtuxViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}






