// PlayerDetailView.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct PlayerDetailView: View {
  @StateObject private var viewModel: PlayerDetailViewModel
  
  init(player: Player,
       onPlayerChanged: @escaping (Player) -> Void = { _ in }) {
    self._viewModel = StateObject(wrappedValue: PlayerDetailViewModel(player: player, onPlayerChanged: onPlayerChanged))
  }
  
  var body: some View {
    VStack(spacing: 20) {
      picture
      Text("Score: \(viewModel.player.score)")
        .font(.largeTitle)
      Spacer()
      Button(action: viewModel.showChangeScoreView) {
        Text("Change score")
          .font(.title)
          .padding()
          .foregroundColor(.white)
          .background(Color.blue)
          .clipShape(RoundedRectangle(cornerRadius: 10))
      }
    }
    .padding()
    .navigationBarTitle(viewModel.player.name)
    .toolbar { toolbar }
    .sheet(isPresented: $viewModel.showingPlayerEdit) {
      PlayerEditView(player: viewModel.player, onPlayerChanged: viewModel.notifyPlayerChanged)
    }
    .sheet(isPresented: $viewModel.showingChangeScore) {
      PlayerChangeScoreView(player: viewModel.player, onPlayerChanged: viewModel.notifyPlayerChanged)
      Text("\(viewModel.player.name)")
    }
  }
  
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: viewModel.showPlayerEditView) {
        Image(systemName: "pencil")
      }
    }
  }
  
  var picture: some View {
    Image(uiImage: viewModel.player.pictureImage ?? UIImage(named: "Placeholder")!)
      .resizable()
      .scaledToFit()
      .frame(height: 250)
  }
  
}

struct PlayerDetailView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerDetailView(player: Player.preview)
  }
}
