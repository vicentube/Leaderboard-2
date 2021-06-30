// PreviewDatabaseService.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

final class PreviewDatabaseService: DatabaseServiceProtocol {
  private var players: [Player]
  
  init() {
    players = [
      Player(name: "Darth Vader", score: 20),
      Player(name: "Luke Skywalker", score: 30),
      Player(name: "Han Solo", score: 10),
      Player(name: "Princess Leia", score: 40)
    ]
  }
  
  func fetchAllPlayers(completion: @escaping ([Player]) -> Void) {
    completion(players)
  }
  
  func deletePlayers(_ players: [Player], completion: @escaping (Bool) -> Void) {
    for player in players {
      if let index = self.players.firstIndex(where: { $0.id == player.id }) {
        self.players.remove(at: index)
      }
    }
    completion(true)
  }
  
  func savePlayer(_ player: Player, completion: @escaping (Bool) -> Void) {
    if let index = players.firstIndex(where: { $0.id == player.id }) {
      // update
      players[index] = player
    } else {
      // create
      players.append(player)
    }
    completion(true)
  }
  
}

