//
//  DetailViewController.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit
import RxSwift
import Core

public class DetailViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  @IBOutlet weak var ratingLbl: UILabel!
  @IBOutlet weak var releaseDateLbl: UILabel!
  @IBOutlet weak var genresLbl: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControll: UIPageControl!
  @IBOutlet weak var descLbl: UILabel!
  @IBOutlet weak var videoView: Video!
  
  private let detailPresenter: DetailPresenter
  
  public init(detailPresenter: DetailPresenter) {
    self.detailPresenter = detailPresenter
    super.init(nibName: String(describing: DetailViewController.self), bundle: Bundle(identifier: "com.dicoding.academy.Detail"))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    setDefaultNavigationTheme()
    configureLeftNavigationBar()
    configureRightNavigationBar()
    configureViews()
    observeViewModel()
    requestAPI()
  }
  
  private func setDefaultNavigationTheme() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor  = .white
    navigationController?.interactivePopGestureRecognizer?.delegate = nil
  }
  
  private func configureLeftNavigationBar() {
    let customIcon = UIImage(named: "icon-back")?.resizeImg(targetSize: CGSize(width: 24, height: 24))
    let customButton = UIBarButtonItem(image: customIcon, style: .plain, target: self, action: #selector(self.leftNavigationBarButtonTapped))
    customButton.tintColor = .black
    
    let titleLabel = UILabel()
    titleLabel.font = .boldFont(withSize: 14)
    titleLabel.text = "Detail Game"
    titleLabel.textColor = .black
    let customLabel = UIBarButtonItem(customView: titleLabel)
    
    navigationItem.leftBarButtonItems = [customButton, customLabel]
  }
  
  private func configureRightNavigationBar() {
    var favoriteIcon = GlobalFunction.getImageFavoriteDelected()
    if detailPresenter.isFavorit ?? false {
      favoriteIcon = GlobalFunction.getImageFavoriteSelected()
    }
    let customButton = UIBarButtonItem(image: favoriteIcon, style: .plain, target: self, action: #selector(self.rightNavigationBarButtonTapped))
    
    navigationItem.rightBarButtonItems = [customButton]
  }
  
  private func configureViews() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib.init(nibName: String(describing: ListCarousellCollectionViewCell.self), bundle: Bundle(identifier: "com.dicoding.academy.Detail")), forCellWithReuseIdentifier: "cellCarousell")
  }
  
  func observeViewModel() {
    detailPresenter.isLoading.asObservable().subscribe(onNext: { (loading) in
      if loading {
        Indicator.sharedInstance.show()
      } else {
        Indicator.sharedInstance.hide()
      }
    }).disposed(by: disposeBag)
    
    detailPresenter.detailGame.subscribe(onNext: { [weak self] (response) in
      guard response != nil else { return }
      DispatchQueue.main.async {
        self?.configVideo()
        self?.setContent()
      }
    }).disposed(by: disposeBag)
    
    detailPresenter.shortScreenshots.subscribe(onNext: { [weak self] (response) in
      guard response != nil else { return }
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }).disposed(by: disposeBag)
    
    detailPresenter.isAdded.subscribe(onNext: {(response) in
      guard response != nil else { return }
      
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Successful", message: "Game favorit added.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
          self.detailPresenter.isFavorit = true
          self.configureRightNavigationBar()
        })
        self.present(alert, animated: true, completion: nil)
      }
    }).disposed(by: disposeBag)
    
    detailPresenter.isDeleted.subscribe(onNext: {(response) in
      guard response != nil else { return }
      
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Successful", message: "Game favorit deleted.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
          self.detailPresenter.isFavorit = false
          self.configureRightNavigationBar()
        })
        self.present(alert, animated: true, completion: nil)
      }
    }).disposed(by: disposeBag)
  }
  
  private func requestAPI() {
    detailPresenter.requestGetDetail()
    detailPresenter.requestGetScreenshots()
  }
  
  func configVideo() {
    if let clip = detailPresenter.detailGame.value?.clip?.clips?.quality640 {
      videoView.clip = clip
    }
  }
  
  private func setContent() {
    ratingLbl.text = "Rating: \(detailPresenter.detailGame.value?.rating ?? 0)"
    releaseDateLbl.text = "Release Date: \(detailPresenter.detailGame.value?.released ?? "")"
    genresLbl.text = "Genres: \(detailPresenter.getGenre())"
    descLbl.text = "Description game \n\n\(detailPresenter.detailGame.value?.descriptionRaw ?? "")"
  }
  
  private func setScreenshots() {
    pageControll.numberOfPages = detailPresenter.shortScreenshots.value?.count ?? 0
  }
  
  @objc func leftNavigationBarButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func rightNavigationBarButtonTapped() {
    if detailPresenter.isFavorit ?? false {
      if let id = detailPresenter.id {
        detailPresenter.requestDeleteFavorit(id)
      }
    } else {
      if let data = detailPresenter.detailGame.value, let platforms = detailPresenter.detailGame.value?.platforms {
        detailPresenter.requestAddFavorit(data, detailPresenter.getGenre(), detailPresenter.getPlatforms(data: platforms))
      }
    }
    
  }
}

extension DetailViewController: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    detailPresenter.shortScreenshots.value?.count ?? 0
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell: ListCarousellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCarousell", for: indexPath) as! ListCarousellCollectionViewCell
    cell.listImage.setImage(urlString: detailPresenter.shortScreenshots.value?.results?[indexPath.row].image ?? "")
    return cell
  }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let currentPage = Int(ceil(scrollView.contentOffset.x / scrollView.frame.size.width))
    pageControll.currentPage = currentPage
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width, height: 250)
  }
}
