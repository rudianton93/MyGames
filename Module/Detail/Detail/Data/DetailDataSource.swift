//
//  DetailDataSource.swift
//  MyGames
//
//  Created by Rudi Anton on 14/03/23.
//

import Foundation
import RxAlamofire
import RxSwift
import Core
import CoreData

public class DetailDataSource: DetailDataSourceProtocol {
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Favorit")
    
    container.loadPersistentStores { _, error in
      guard error == nil else {
        fatalError("Unresolved error \(error!)")
      }
    }
    container.viewContext.automaticallyMergesChangesFromParent = false
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.shouldDeleteInaccessibleFaults = true
    container.viewContext.undoManager = nil
    
    return container
  }()
  
  public func newTaskContext() -> NSManagedObjectContext {
    let taskContext = persistentContainer.newBackgroundContext()
    taskContext.undoManager = nil
    
    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return taskContext
  }
  
  public init() {}
  
  public let disposeBag = DisposeBag()
  
  public func getDetailFromSource(id: Int64, completion: @escaping (DetailGames) -> ()) {
    let urlString = "\(GlobalFunction.baseUrl)/\(id)"
    let parameters = ["key": "\(GlobalFunction.apiKey)"]
    
    RxAlamofire.json(.get, urlString, parameters: parameters).debug()
      .subscribe(onNext: {(response) in
        let decoder = JSONDecoder()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: response) else {return print("error with data")}
        guard let json: DetailGames = try? decoder.decode(DetailGames.self, from: jsonData) else {return print("error with json")}
        completion(json)
      }).disposed(by: disposeBag)
  }
  
  public func getScreenshotsFromSource(id: Int64, completion: @escaping (DataScreenshots) -> ()) {
    let urlString = "\(GlobalFunction.baseUrl)/\(id)/screenshots"
    let parameters = ["key": "\(GlobalFunction.apiKey)"]
    
    RxAlamofire.json(.get, urlString, parameters: parameters).debug()
      .subscribe(onNext: {(response) in
        let decoder = JSONDecoder()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: response) else {return print("error with data")}
        guard let json: DataScreenshots = try? decoder.decode(DataScreenshots.self, from: jsonData) else {return print("error with json")}
        completion(json)
      }).disposed(by: disposeBag)
  }
  
  public func addFavoritFromSource(_ data: DetailGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      if let entity = NSEntityDescription.entity(forEntityName: "Entity", in: taskContext) {
        let favorit = NSManagedObject(entity: entity, insertInto: taskContext)
        favorit.setValue(data.id, forKeyPath: "id")
        favorit.setValue(data.name, forKeyPath: "name")
        favorit.setValue(data.released, forKeyPath: "released")
        favorit.setValue(data.backgroundImage, forKeyPath: "backgroundImage")
        favorit.setValue(data.rating, forKeyPath: "rating")
        favorit.setValue(platforms, forKeyPath: "platforms")
        
        do {
          try taskContext.save()
          completion()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }
    }
  }
  
  public func deleteFavoritFromSource(_ id: Int64, completion: @escaping() -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      batchDeleteRequest.resultType = .resultTypeCount
      if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
        if batchDeleteResult.result != nil {
          completion()
        }
      }
    }
  }
  
}
