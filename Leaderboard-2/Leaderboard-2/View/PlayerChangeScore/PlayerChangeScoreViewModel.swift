// PlayerChangeScoreViewModel.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine

final class PlayerChangeScoreViewModel: ObservableObject {
  private let model: LeaderboardModel = .shared
  private var cancellable: AnyCancellable?
  private let index: Int
  
  @Published var newScoreText = ""
  
  var closeView: (() -> Void)!
  
  var player: Player {
    get { model.players[index] }
    set { model.players[index] = newValue }
  }
  
  init(player: Player) {
    self.index = model.index(of: player)!
    // subscribe to model changes to notify the view
    self.cancellable = model.objectWillChange.sink(receiveValue: { [weak self] in
      self?.objectWillChange.send()
    })
  }
  
  func saveAndClose() {
    // check if newScore is a valid number
    if let newScore = Int(newScoreText) {
      // update player, persist it and close view
      player.score = newScore
      model.savePlayer(player)
      closeView()
    } else {
      // reset text and continue in the view
      newScoreText = ""
    }
  }
}
