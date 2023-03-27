//
//  DetailPresenter.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Foundation
import RxCocoa
import RxSwift

public class DetailPresenter: DetailPresenterProtocol {
 
  private let detailUseCase: DetailUseCase
  private let disposeBag = DisposeBag()
  
  var isLoading: BehaviorRelay<Bool>
  var detailGame: BehaviorRelay<DetailGames?>
  var shortScreenshots: BehaviorRelay<DataScreenshots?>
  var isAdded: BehaviorRelay<Bool?>
  var isDeleted: BehaviorRelay<Bool?>
  
  public var isFavorit: Bool?
  public var id: Int64?
  
  public init(useCase: DetailUseCase) {
    self.detailUseCase = useCase
    isLoading = BehaviorRelay(value: false)
    detailGame = BehaviorRelay(value: nil)
    shortScreenshots = BehaviorRelay(value: nil)
    isAdded = BehaviorRelay(value: nil)
    isDeleted = BehaviorRelay(value: nil)
  }
  
  func requestGetDetail() {
    self.isLoading.accept(true)
    return detailUseCase.getDetail(id: id ?? 0, completion: { (json) in
      self.isLoading.accept(false)
      self.detailGame.accept(json)
    })
  }
  
  func requestGetScreenshots() {
    self.isLoading.accept(true)
    return detailUseCase.getScreenshots(id: id ?? 0, completion: { (json) in
      self.isLoading.accept(false)
      self.shortScreenshots.accept(json)
    })
  }
  
  func requestAddFavorit(_ data: DetailGames, _ genres: String, _ platforms: String) {
    self.isLoading.accept(true)
    return detailUseCase.addFavorit(data, genres, platforms, completion: {
      self.isLoading.accept(false)
      self.isAdded.accept(true)
    })
  }
  
  func requestDeleteFavorit(_ id: Int64) {
    self.isLoading.accept(true)
    return detailUseCase.deleteFavorit(id, completion: {
      self.isLoading.accept(false)
      self.isDeleted.accept(true)
    })
  }
  
  func getGenre() -> String {
    let genres = detailGame.value?.genres
    var listGenre = ""
    if let countData = genres?.count {
      for index in 0...countData - 1 {
        listGenre += "\(genres?[index].name ?? "")"
        listGenre += index == countData - 1 ? " " : ", "
      }
    }
    return listGenre
  }
  
  func getPlatforms(data: [Platforms]) -> String {
    var listPlatforms = ""
    for index in 0...data.count - 1 {
      listPlatforms += "\(data[index].platform?.name ?? "")"
      listPlatforms += index == data.count - 1 ? " " : ", "
    }
    return listPlatforms
  }
}
