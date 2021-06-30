// Leaderboard.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct Leaderboard {
  var players: [Player] = []
  
  mutating func move(indices: IndexSet, newOffset: Int) {
    players.move(fromOffsets: indices, toOffset: newOffset)
  }
  
  mutating func sort() {
    players.sort(by: { $0.score > $1.score })
  }
}
