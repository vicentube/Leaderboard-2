// PlayerListViewModel.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import Combine

final class PlayerListViewModel: ObservableObject {
  private let model = PlayerStore.shared
  private var cancellable: AnyCancellable?
  
  @Published var showingNewPlayer = false
  
  var players: [Player] {
    model.players
  }
  
  init() {
    cancellable = model.objectWillChange.sink { [weak self] in
      self?.objectWillChange.send()
    }
    model.getAllPlayers()
  }
  
  func movePlayers(indices: IndexSet, newOffset: Int) {
    model.move(indices: indices, newOffset: newOffset)
  }
  
  func deletePlayers(indexSet: IndexSet) {
    model.deletePlayers(indexSet: indexSet)
  }
  
  func sortLeaderboard() {
    model.sort()
  }
  
  func showNewPlayerView() {
    showingNewPlayer = true
  }
}
