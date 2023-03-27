//
//  FavoritPresenter.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Foundation
import RxCocoa
import RxSwift
import Core

public class FavoritPresenter: FavoritPresenterProtocol {
  
  private let favoritUseCase: FavoritUseCase
  
  public var isLoading: BehaviorRelay<Bool>
  var dataFavorit: BehaviorRelay<[Favorit]?>
  public var dataGames: BehaviorRelay<DataGames?>
  public var isFavorit: BehaviorRelay<Bool?>
  var isAdded: BehaviorRelay<Bool?>
  var isDeleted: BehaviorRelay<Bool?>
  public var idFavorit: BehaviorRelay<Int64?>
  
  var isEmpty = false
  
  public init(useCase: FavoritUseCase) {
    self.favoritUseCase = useCase
    isLoading = BehaviorRelay(value: false)
    dataFavorit = BehaviorRelay(value: nil)
    dataGames = BehaviorRelay(value: nil)
    isFavorit = BehaviorRelay(value: nil)
    isAdded = BehaviorRelay(value: nil)
    isDeleted = BehaviorRelay(value: nil)
    idFavorit = BehaviorRelay(value: 0)
  }
  
  public func requestGetData(search: String) {
    self.isLoading.accept(true)
    return favoritUseCase.getData(search: search, completion: { (json) in
      self.isLoading.accept(false)
      self.dataGames.accept(json)
    })
  }
  
  func requestGetFavorit() {
    self.isLoading.accept(true)
    return favoritUseCase.getFavorit(completion: { (json) in
      self.isLoading.accept(false)
      self.dataFavorit.accept(json)
      if json.count == 0 {
        self.isEmpty = true
      } else {
        self.isEmpty = false
      }
    })
  }
  
  public func requestGetSameId(_ id: Int64) {
    self.isLoading.accept(true)
    self.idFavorit.accept(id)
    return favoritUseCase.getSameId(id, completion: { (json) in
      self.isLoading.accept(false)
      self.isFavorit.accept(json)
    })
  }
  
  func requestAddFavorit(_ data: FavoritGames, _ genres: String, _ platforms: String) {
    self.isLoading.accept(true)
    return favoritUseCase.addFavorit(data, genres, platforms, completion: {
      self.isLoading.accept(false)
      self.isAdded.accept(true)
    })
  }
  
  func requestDeleteFavorit(_ id: Int64) {
    self.isLoading.accept(true)
    return favoritUseCase.deleteFavorit(id, completion: {
      self.isLoading.accept(false)
      self.isDeleted.accept(true)
    })
  }
  
}
