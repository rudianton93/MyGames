//
//  SearchViewController.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit
import RxSwift
import Favorit
import Core
import Detail

public class SearchViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  @IBOutlet weak var searchField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  private let favoritPresenter: FavoritPresenter
  
  public init(favoritPresenter: FavoritPresenter) {
    self.favoritPresenter = favoritPresenter
    super.init(nibName: String(describing: SearchViewController.self), bundle: Bundle(identifier: "com.dicoding.academy.Search"))
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
  
  private func setDefaultNavigationTheme() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor  = .white
    navigationController?.interactivePopGestureRecognizer?.delegate = nil
  }
  
  private func configureNavigationBar() {
    let customIcon = UIImage(named: "icon-back")?.resizeImg(targetSize: CGSize(width: 24, height: 24))
    let customButton = UIBarButtonItem(image: customIcon, style: .plain, target: self, action: #selector(self.leftNavigationBarButtonTapped))
    customButton.tintColor = .black
    
    let titleLabel = UILabel()
    titleLabel.font = .boldFont(withSize: 14)
    titleLabel.text = "Search Game"
    titleLabel.textColor = .black
    let customLabel = UIBarButtonItem(customView: titleLabel)
    
    navigationItem.leftBarButtonItems = [customButton, customLabel]
  }
  
  private func configureViews() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib.init(nibName: String(describing: ListSearchTableViewCell.self), bundle: Bundle(identifier: "com.dicoding.academy.Search")), forCellReuseIdentifier: "listSearchCell")
  }
  
  func observeViewModel() {
    favoritPresenter.isLoading.asObservable().subscribe(onNext: { (loading) in
      if loading {
        Indicator.sharedInstance.show()
      } else {
        Indicator.sharedInstance.hide()
      }
    }).disposed(by: disposeBag)
    
    favoritPresenter.dataGames.subscribe(onNext: { [weak self] (response) in
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
    let detailUsecase = DetailInjection.init().detailProvideUseCase()
    let detailPresenter = DetailPresenter(useCase: detailUsecase)
    detailPresenter.id = self.favoritPresenter.idFavorit.value
    detailPresenter.isFavorit = response
    
    DispatchQueue.main.async {
      self.navigationController?.pushViewController(DetailViewController(detailPresenter: detailPresenter), animated: true)
    }
  }
  
  @objc func leftNavigationBarButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func onChangeText(_ sender: Any) {
    Indicator.sharedInstance.show()
    favoritPresenter.requestGetData(search: searchField.text ?? "")
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ListSearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "listSearchCell", for: indexPath) as! ListSearchTableViewCell
    cell.gameImg.setImage(urlString: favoritPresenter.dataGames.value?.results?[indexPath.row].backgroundImage ?? "")
    cell.nameLbl.text = favoritPresenter.dataGames.value?.results?[indexPath.row].name ?? "-"
    cell.descLbl.text = favoritPresenter.dataGames.value?.results?[indexPath.row].descriptionRaw ?? "-"
    return cell
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoritPresenter.dataGames.value?.results?.count ?? 0
  }
  
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let id = favoritPresenter.dataGames.value?.results?[indexPath.row].id {
      favoritPresenter.requestGetSameId(id)
    }
  }
  
}

