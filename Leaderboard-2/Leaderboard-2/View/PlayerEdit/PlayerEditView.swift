// PlayerEditView.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct PlayerEditView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @StateObject private var viewModel: PlayerEditViewModel
  @State private var showingImagePicker = false
  
  let thumbnailSize = CGSize(width: 50, height: 50)
  
  init(player: Player) {
    self._viewModel = StateObject(wrappedValue: PlayerEditViewModel(player: player))
  }
  
  var body: some View {
    VStack {
      toolbar
      ZStack {
        Form {
          name
          picture
        }
      }
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
  
  var name: some View {
    TextField("Player name", text: $viewModel.player.name)
  }
  
  var picture: some View {
    HStack {
      Text("Player image")
      Spacer()
      Image(uiImage: viewModel.playerPicture
              ?? viewModel.player.pictureImage
              ?? UIImage(named: "Placeholder")!)
        .resizable()
        .scaledToFill()
        .frame(width: thumbnailSize.width, height: thumbnailSize.height)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    .onTapGesture { showingImagePicker = true }
    .sheet(isPresented: $showingImagePicker, onDismiss: viewModel.onDismissImagePicker) {
      ImagePicker(image: $viewModel.pickedImage)
    }
  }

}

struct PlayerEditView_Previews: PreviewProvider {
  static var previews: some View {
    let model = LeaderboardModel.preview
    return PlayerEditView(player: model.players[0])
  }
}
