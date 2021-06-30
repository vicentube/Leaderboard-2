// Services.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

struct Services {
  let database: DatabaseServiceProtocol
  
  init(database: DatabaseServiceProtocol) {
    self.database = database
  }
}

extension Services {
  static var app: Services {
    Services(database: CoreDataService())
  }
}
