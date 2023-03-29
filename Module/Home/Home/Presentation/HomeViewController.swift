//
//  HomeViewController.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit
import RxSwift
import Favorit
import Core
import Detail
import Search

public class HomeViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBtn: UIButton!
  @IBOutlet weak var iconSearch: UIImageView!
  
  private let homePresenter: HomePresenter
  private let favoritPresenter: FavoritPresenter
  
  public init(homePresenter: HomePresenter, favoritPresenter: FavoritPresenter) {
    self.homePresenter = homePresenter
    self.favoritPresenter = favoritPresenter
    super.init(nibName: String(describing: HomeViewController.self), bundle: Bundle(identifier: "com.dicoding.academy.Home"))
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
    homePresenter.requestGetData(search: "")
    
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
    titleLabel.text = "Home"
    titleLabel.textColor = .black
    
    navigationItem.titleView = titleLabel
  }
  
  func configureViews() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib.init(nibName: String(describing: GamesTableViewCell.self), bundle: Bundle(identifier: "com.dicoding.academy.Core")), forCellReuseIdentifier: "cell")
    tableView.contentInset = UIEdgeInsets(top: 72, left: 0, bottom: 0, right: 0)
    
    iconSearch.image = UIImage(named: "search")
    searchBtn.addShadow()
  }
  
  func observeViewModel() {
    homePresenter.isLoading.asObservable().subscribe(onNext: { (loading) in
      if loading {
        Indicator.sharedInstance.show()
      } else {
        Indicator.sharedInstance.hide()
      }
    }).disposed(by: disposeBag)
    
    homePresenter.dataGames.subscribe(onNext: { [weak self] (response) in
      guard response != nil else { return }
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }).disposed(by: disposeBag)
    
    favoritPresenter.isFavorit.subscribe(onNext: { [weak self] (response) in
      guard response != nil else { return }
      self?.goToDetail(response: response ?? false)
    }).disposed(by: disposeBag)
  }
  
  func goToDetail(response: Bool) {
    let detailUsecase = Injection.init().detailProvideUseCase()
    let detailPresenter = DetailPresenter(useCase: detailUsecase)
    detailPresenter.id = self.favoritPresenter.idFavorit.value
    detailPresenter.isFavorit = response
    
    DispatchQueue.main.async {
      self.navigationController?.pushViewController(DetailViewController(detailPresenter: detailPresenter), animated: true)
    }
  }
  
  @IBAction func actionSearch(_ sender: Any) {
    let favoritUsecase = Injection.init().favoritProvideUseCase()
    let favoritPresenter = FavoritPresenter(useCase: favoritUsecase)
    favoritPresenter.dataGames.accept(homePresenter.dataGames.value)
    self.navigationController?.pushViewController(SearchViewController(favoritPresenter: favoritPresenter), animated: true)
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: GamesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GamesTableViewCell
    cell.gameImage.setImage(urlString: homePresenter.dataGames.value?.results?[indexPath.row].backgroundImage ?? "")
    cell.titleLbl.text = homePresenter.dataGames.value?.results?[indexPath.row].name ?? "-"
    cell.dateLbl.text = "Release Date: \(homePresenter.dataGames.value?.results?[indexPath.row].released ?? "-")"
    cell.rateLbl.text = "Rating: \(homePresenter.dataGames.value?.results?[indexPath.row].rating ?? 0)"
    cell.favoritBtn.setImage(UIImage(named: "icon-favorite-selected"), for: .normal)
    if let platforms = homePresenter.dataGames.value?.results?[indexPath.row].platforms {
      cell.descLbl.text = "Platforms: \(homePresenter.getPlatforms(data: platforms))"
    }
    return cell
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return homePresenter.dataGames.value?.results?.count ?? 0
  }
  
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let id = homePresenter.dataGames.value?.results?[indexPath.row].id {
      favoritPresenter.requestGetSameId(id)
    }
  }
  
}

