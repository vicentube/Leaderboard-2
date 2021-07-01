// Previews.swift
// Leaderboard-2
//
// Creado el 1/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

extension LeaderboardModel {
  static var preview: LeaderboardModel {
    LeaderboardModel.shared = LeaderboardModel(services: .preview)
    return LeaderboardModel.shared
  }
}

extension Services {
  static var preview: Services {
    Services(database: PreviewDatabaseService())
  }
}
