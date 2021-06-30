// PlayerStore.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import Combine

final class PlayerStore: ObservableObject {
  static var shared = PlayerStore()
  
  @Published var players: [Player] = []
  
  private let services: Services
  
  init(services: Services = .app) {
    self.services = services
  }
  
  func move(indices: IndexSet, newOffset: Int) {
    players.move(fromOffsets: indices, toOffset: newOffset)
  }
  
  func sort() {
    players.sort(by: { $0.score > $1.score })
  }
  
  func getAllPlayers() {
    services.database.fetchAllPlayers { [weak self] result in
      self?.players = result
    }
  }
  
  func deletePlayers(indexSet: IndexSet) {
    let itemsToDelete = indexSet.map { players[$0] }
    // delete players from database
    services.database.deletePlayers(itemsToDelete) { [weak self] done in
      guard done else { return }
      indexSet.forEach { index in
        // delete picture associated to the player
        self?.players[index].deletePicture()
      }
      // remove players from memory store
      self?.players.remove(atOffsets: indexSet)
    }
  }
  
  func savePlayer(_ player: Player) {
    // persist to database
    services.database.savePlayer(player) { [weak self] done in
      guard done else { return }
      // check if its new player or edited
      if let index = self?.players.firstIndex(where: { $0.id == player.id }) {
        self?.players[index] = player
      } else {
        self?.players.append(player)
      }
    }
  }
}

extension PlayerStore {
  static func preview() {
    PlayerStore.shared = PlayerStore(services: .preview)
  }
}
