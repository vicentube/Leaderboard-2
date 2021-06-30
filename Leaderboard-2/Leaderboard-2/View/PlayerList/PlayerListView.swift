// PlayerListView.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct PlayerListView: View {
  @StateObject private var viewModel: PlayerListViewModel
  
  init(services: Services = .app) {
    self._viewModel = StateObject(wrappedValue: PlayerListViewModel())
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        List {
          ForEach(viewModel.players) { player in
            NavigationLink(destination: PlayerDetailView(player: player, onPlayerChanged: viewModel.savePlayer)) {
              PlayerRow(player: player)
            }
          }
          .onMove(perform: viewModel.movePlayers)
          .onDelete(perform: viewModel.deletePlayers)
        }
        .navigationBarTitle("Players")
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button(action: viewModel.sortLeaderboard) {
              Image(systemName: "arrow.up.arrow.down")
            }
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            EditButton()
          }
        }
        .sheet(isPresented: $viewModel.showingNewPlayer) {
          PlayerEditView(player: Player(), onPlayerChanged: viewModel.savePlayer)
        }
        newPlayerButton
      }
    }
  }
  
  var newPlayerButton: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        Button(action: viewModel.showNewPlayerView) {
          Image(systemName: "plus.circle.fill")
            .font(.system(size: 60))
            .padding()
        }
      }
    }
  }
}

struct PlayerListView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerListView(services: .preview)
  }
}
