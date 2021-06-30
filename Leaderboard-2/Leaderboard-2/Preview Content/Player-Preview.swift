// Player-Preview.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

extension Player {
  static var preview: Player {
    Player(id: UUID(), name: "Preview player", score: 30, pictureId: nil)
  }
}
