// PlayerDetailView.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct PlayerDetailView: View {
  
  let player: Player
  
  @State private var showingChangeScore = false
  @State private var showingPlayerEdit = false
  
  var body: some View {
    VStack(spacing: 20) {
      picture
      Text("Score: \(player.score)")
        .font(.largeTitle)
      Spacer()
      Button(action: { showingChangeScore = true }) {
        Text("Change score")
          .font(.title)
          .padding()
          .foregroundColor(.white)
          .background(Color.blue)
          .clipShape(RoundedRectangle(cornerRadius: 10))
      }
    }
    .padding()
    .navigationBarTitle(player.name)
    .toolbar { toolbar }
    .sheet(isPresented: $showingPlayerEdit) {
      PlayerEditView(player: player)
    }
    .sheet(isPresented: $showingChangeScore) {
      PlayerChangeScoreView(player: player)
      Text("\(player.name)")
    }
  }
  
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: { showingPlayerEdit = true }) {
        Image(systemName: "pencil")
      }
    }
  }
  
  var picture: some View {
    Image(uiImage: player.pictureImage ?? UIImage(named: "Placeholder")!)
      .resizable()
      .scaledToFit()
      .frame(height: 250)
  }
  
}

struct PlayerDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let model = LeaderboardModel.preview
    return PlayerDetailView(player: model.players[0])
  }
}
