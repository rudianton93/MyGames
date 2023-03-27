//
//  Injection.swift
//  Detail
//
//  Created by Rudi Anton on 24/03/23.
//

public final class DetailInjection: NSObject {
  public func detailProvideDataSource() -> DetailDataSourceProtocol {
    return DetailDataSource()
  }
  
  public func detailProvideRepository() -> DetailRepositoryProtocol {
    let detailDataSource = detailProvideDataSource()
    return DetailRepository(dataSource: detailDataSource)
  }
  
  public func detailProvideUseCase() -> DetailUseCase {
    let detailRepository = detailProvideRepository()
    return DetailInteractor(repository: detailRepository)
  }
  
}
