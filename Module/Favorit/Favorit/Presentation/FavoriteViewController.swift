//
//  FavoriteViewController.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit
import RxSwift
import Core
import Detail

public class FavoriteViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  @IBOutlet weak var tableView: UITableView!
  
  private let favoritPresenter: FavoritPresenter
  
  public init(favoritPresenter: FavoritPresenter) {
    self.favoritPresenter = favoritPresenter
    super.init(nibName: String(describing: FavoriteViewController.self), bundle: Bundle(identifier: "com.dicoding.academy.Favorit"))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    setDefaultNavigationTheme()
    configureNavigationBar()
    configureViews()
    observeViewModel()
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    requestAPI()
  }
  
  private func setDefaultNavigationTheme() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor  = .white
    navigationController?.interactivePopGestureRecognizer?.delegate = nil
  }
  
  private func configureNavigationBar() {
    let titleLabel = UILabel()
    titleLabel.font = .boldFont(withSize: 14)
    titleLabel.text = "Favorit"
    titleLabel.textColor = .black
    
    navigationItem.titleView = titleLabel
  }
  
  private func requestAPI() {
    favoritPresenter.requestGetFavorit()
  }
  
  func configureViews() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib.init(nibName: String(describing: GamesTableViewCell.self), bundle: Bundle(identifier: "com.dicoding.academy.Core")), forCellReuseIdentifier: "cell")
    tableView.register(UINib.init(nibName: String(describing: EmptyFavoritTableViewCell.self), bundle: Bundle(identifier: "com.dicoding.academy.Favorit")), forCellReuseIdentifier: "cellEmpty")
  }
  
  func observeViewModel() {
    favoritPresenter.isLoading.asObservable().subscribe(onNext: { (loading) in
      if loading {
        Indicator.sharedInstance.show()
      } else {
        Indicator.sharedInstance.hide()
      }
    }).disposed(by: disposeBag)
    
    favoritPresenter.dataFavorit.subscribe(onNext: { [weak self] (response) in
      guard response != nil else { return }
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }).disposed(by: disposeBag)
    
    favoritPresenter.isDeleted.subscribe(onNext: { [weak self] (response) in
      guard response != nil else { return }
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Successful", message: "Game favorit deleted.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
          self?.requestAPI()
        })
        self?.present(alert, animated: true, completion: nil)
      }
    }).disposed(by: disposeBag)
  }
  
  @objc func leftNavigationBarButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  func deleteFavorit(index: Int) {
    if let id = favoritPresenter.dataFavorit.value?[index].id {
      favoritPresenter.requestDeleteFavorit(id)
    }
  }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if favoritPresenter.isEmpty == true {
      let cell: EmptyFavoritTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellEmpty", for: indexPath) as! EmptyFavoritTableViewCell
      return cell
    } else {
      let cell: GamesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GamesTableViewCell
      
      cell.favoritBtn.isHidden = false
      cell.gameImage.setImage(urlString: favoritPresenter.dataFavorit.value?[indexPath.row].backgroundImage ?? "")
      cell.titleLbl.text = favoritPresenter.dataFavorit.value?[indexPath.row].name ?? "-"
      cell.dateLbl.text = "Release Date: \(favoritPresenter.dataFavorit.value?[indexPath.row].released ?? "-")"
      cell.rateLbl.text = "Rating: \(favoritPresenter.dataFavorit.value?[indexPath.row].rating ?? 0)"
      cell.descLbl.text = "Platforms: \(favoritPresenter.dataFavorit.value?[indexPath.row].platforms ?? "")"
      cell.favoritBtn.setImage(UIImage(named: "icon-favorite-selected"), for: .normal)
      
      cell.favoritTapped = {
        self.deleteFavorit(index: indexPath.row)
      }
      return cell
    }
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if favoritPresenter.isEmpty == true {
      return 1
    }
    return favoritPresenter.dataFavorit.value?.count ?? 0
  }
  
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func goToDetail(id: Int64) {
    let detailUsecase = DetailInjection.init().detailProvideUseCase()
    let detailPresenter = DetailPresenter(useCase: detailUsecase)
    detailPresenter.id = id
    detailPresenter.isFavorit = true
    
    DispatchQueue.main.async {
      self.navigationController?.pushViewController(DetailViewController(detailPresenter: detailPresenter), animated: true)
    }
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let id = self.favoritPresenter.dataFavorit.value?[indexPath.row].id {
      goToDetail(id: id)
    }
  }
  
}
