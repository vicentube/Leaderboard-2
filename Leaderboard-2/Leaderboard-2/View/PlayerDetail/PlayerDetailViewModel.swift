// PlayerDetailViewModel.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

final class PlayerDetailViewModel: ObservableObject {
  @Published var player: Player
  var playerChanged: (Player) -> Void
  
  @Published var showingChangeScore = false
  @Published var showingPlayerEdit = false
  
  init(player: Player, onPlayerChanged: @escaping (Player) -> Void) {
    self.player = player
    self.playerChanged = onPlayerChanged
  }
  
  func showPlayerEditView() {
    showingPlayerEdit = true
  }
  
  func showChangeScoreView() {
    showingChangeScore = true
  }
  
  func notifyPlayerChanged(_ player: Player) {
    // close any open sheet
    showingChangeScore = false
    showingPlayerEdit = false
    playerChanged(player)
  }
}
