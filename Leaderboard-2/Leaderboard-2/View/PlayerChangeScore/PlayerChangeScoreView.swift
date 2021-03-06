// PlayerChangeScoreView.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct PlayerChangeScoreView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @StateObject private var viewModel: PlayerChangeScoreViewModel
  
  init(player: Player) {
    self._viewModel = StateObject(wrappedValue: PlayerChangeScoreViewModel(player: player))
  }
  
  var body: some View {
    VStack {
      toolbar
      Group {
        Text("Change score of")
          .font(.body)
        Text(viewModel.player.name)
        picture
        Text("Old score: \(viewModel.player.score)")
          .padding()
        TextField("New score", text: $viewModel.newScoreText)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
      }
      .font(.title)
      Spacer()
    }
    .onAppear {
      viewModel.closeView = { presentationMode.wrappedValue.dismiss() }
    }
  }
  
  var toolbar: some View {
    HStack {
      Button(action: viewModel.closeView) {
        Text("Cancel")
      }
      Spacer()
      Button(action: viewModel.saveAndClose) {
        Text("Done")
          .fontWeight(.bold)
      }
    }
    .padding()
  }
  
  var picture: some View {
    Image(uiImage: viewModel.player.pictureImage ?? UIImage(named: "Placeholder")!)
      .resizable()
      .scaledToFit()
      .frame(height: 100)
  }
  
}

struct PlayerChangeScoreView_Previews: PreviewProvider {
    static var previews: some View {
      let model = LeaderboardModel.preview
      return PlayerChangeScoreView(player: model.players[0])
    }
}
