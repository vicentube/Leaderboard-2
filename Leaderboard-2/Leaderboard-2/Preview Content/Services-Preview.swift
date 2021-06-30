// Services-Preview.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

extension Services {
  static var preview: Services {
    Services(database: PreviewDatabaseService())
  }
}
