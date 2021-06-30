// CoreDataService.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import CoreData

protocol DatabaseServiceProtocol {
  func fetchAllPlayers(completion: @escaping ([Player]) -> Void)
  func deletePlayers(_ players: [Player], completion: @escaping (Bool) -> Void)
  func savePlayer(_ player: Player, completion: @escaping (Bool) -> Void)
}

final class CoreDataService: DatabaseServiceProtocol {
  static var persistentContainer = initContainer()
  
  // use a background thread for database access
  private let moc = persistentContainer.newBackgroundContext()
  
  // MARK: - DatabaseServiceProtocol
  
  func fetchAllPlayers(completion: @escaping ([Player]) -> Void) {
    // background work
    moc.perform {
      do {
        // fetch all projects
        let playersMO = try self.fetchAllPlayersMO()
        // convert them to the model type
        let players = playersMO.map { $0.transformToPlayer() }
        DispatchQueue.main.async {
          completion(players)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func deletePlayers(_ players: [Player], completion: @escaping (Bool) -> Void) {
    // background work
    moc.perform {
      do {
        // fetch projects to delete
        let playersMO = try self.fetchPlayersMO(players)
        // mark them to be deleted
        let _ = playersMO.map(self.moc.delete)
        // delete them
        try self.save()
        DispatchQueue.main.async {
          completion(true)
        }
      } catch {
        print(error.localizedDescription)
        DispatchQueue.main.async {
          completion(false)
        }
      }
    }
  }
  
  func savePlayer(_ player: Player, completion: @escaping (Bool) -> Void) {
    // background work
    moc.perform {
      var result = true
      do {
        // fetch player
        let playersMO = try self.fetchPlayersMO([player])
        if let mo = playersMO.first {
          // if exists, then update
          result = mo.updateFromPlayer(player)
        } else {
          // if it doesn't, then create
          let _ = PlayerMO.createFromPlayer(player, context: self.moc)
        }
        try self.save()
        DispatchQueue.main.async {
          completion(result)
        }
      } catch {
        print(error.localizedDescription)
        DispatchQueue.main.async {
          completion(false)
        }
      }
    }
  }
  
  // MARK: - Helper methods
  
  private func fetchAllPlayersMO() throws -> [PlayerMO] {
    let request: NSFetchRequest = PlayerMO.fetchRequest()
    let sort = NSSortDescriptor(key: "name", ascending: true)
    request.sortDescriptors = [sort]
    let result = try moc.fetch(request)
    return result
  }
  
  private func fetchPlayersMO(_ players: [Player]) throws -> [PlayerMO] {
    let ids = players.map { $0.id }
    let request: NSFetchRequest = PlayerMO.fetchRequest()
    request.predicate = NSPredicate(format: "id IN %@", ids)
    let result = try moc.fetch(request)
    return result
  }
  
  private func save() throws {
    if moc.hasChanges {
      try moc.save()
    }
  }
}

extension CoreDataService {
  static func initContainer() -> NSPersistentContainer {
    let container = NSPersistentContainer(name: "Leaderboard")
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }
}

extension PlayerMO {
  private func updatePropertiesFromPlayer(_ player: Player) {
    self.name = player.name
    self.score = Int32(player.score)
    self.pictureId = player.pictureId
  }
  
  static func createFromPlayer(_ player: Player, context: NSManagedObjectContext) -> PlayerMO {
    let mo = PlayerMO(context: context)
    mo.id = player.id
    mo.updatePropertiesFromPlayer(player)
    return mo
  }
  
  func updateFromPlayer(_ player: Player) -> Bool {
    guard player.id == self.id else { return false }
    updatePropertiesFromPlayer(player)
    return true
  }
  
  func transformToPlayer() -> Player {
    Player(id: self.id ?? UUID(),
           name: self.name ?? "",
           score: Int(self.score),
           pictureId: self.pictureId)
  }
}


