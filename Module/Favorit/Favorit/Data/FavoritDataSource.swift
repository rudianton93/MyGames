//
//  FavoritDataSource.swift
//  MyGames
//
//  Created by Rudi Anton on 15/03/23.
//

import Foundation
import CoreData
import Core
import RxAlamofire
import RxSwift

public class FavoritDataSource: FavoritDataSourceProtocol {
  
  public let disposeBag = DisposeBag()
  
  public lazy var persistentContainer: NSPersistentContainer = {
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
  
  public init() {}
  
  private func newTaskContext() -> NSManagedObjectContext {
    let taskContext = persistentContainer.newBackgroundContext()
    taskContext.undoManager = nil
    
    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return taskContext
  }
  
  public func getDataFromSource(search: String, completion: @escaping (DataGames) -> ()) {
    let urlString = "\(GlobalFunction.baseUrl)"
    let parameters = ["key": "\(GlobalFunction.apiKey)", "search": "\(search)"]
    
    RxAlamofire.json(.get, urlString, parameters: parameters).debug()
      .subscribe(onNext: {(response) in
        let decoder = JSONDecoder()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: response) else {return print("error with data")}
        guard let json: DataGames = try? decoder.decode(DataGames.self, from: jsonData) else {return print("error with json")}
        completion(json)
      }).disposed(by: disposeBag)
  }
  
  public func getFavoritFromSource(completion: @escaping(_ favorits: [Favorit]) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
      do {
        let results = try taskContext.fetch(fetchRequest)
        var games: [Favorit] = []
        for result in results {
          let game = Favorit(
            id: result.value(forKeyPath: "id") as? Int64,
            name: result.value(forKeyPath: "name") as? String,
            released: result.value(forKeyPath: "released") as? String,
            backgroundImage: result.value(forKeyPath: "backgroundImage") as? String,
            rating: result.value(forKeyPath: "rating") as? Float,
            platforms: result.value(forKeyPath: "platforms") as? String
          )

          games.append(game)
        }
        completion(games)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }
  
  public func getSameIdFromSource(_ id: Int64, completion: @escaping(_ favorits: Bool) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      do {
        if let _ = try taskContext.fetch(fetchRequest).first {
          completion(true)
        } else {
          completion(false)
        }
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }
  
  public func addFavoritFromSource(_ data: FavoritGames, _ genres: String, _ platforms: String, completion: @escaping() -> Void) {
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
