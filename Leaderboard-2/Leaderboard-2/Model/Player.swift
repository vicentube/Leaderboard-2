// Player.swift
// Leaderboard-2
//
// Creado el 30/6/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import UIKit.UIImage

struct Player: Identifiable {
  
  var id: UUID = UUID()
  var name = ""
  var score = 0
  var pictureId: UUID? = nil
  
  var pictureImage: UIImage? {
    guard let pictureId = pictureId else { return nil }
    let url = getURL(from: pictureId)
    return UIImage(contentsOfFile: url.path)
  }
  
  mutating func savePicture(_ picture: UIImage) {
    // delete previous picture if exists
    deletePicture()
    // new file id
    let newId = UUID()
    // save .jpg
    if let data = picture.jpegData(compressionQuality: 0.8) {
      do {
        try data.write(to: getURL(from: newId), options: [.atomic, .completeFileProtection])
        pictureId = newId
      } catch {
        pictureId = nil
        print(error.localizedDescription)
      }
    } else {
      pictureId = nil
    }
  }
  
  mutating func deletePicture() {
    guard let pictureId = pictureId else { return }
    let url = getURL(from: pictureId)
    if FileManager.default.fileExists(atPath: url.path) {
      try? FileManager.default.removeItem(at: url)
    }
    self.pictureId = nil
  }
  
  private func getURL(from id: UUID) -> URL {
    FileManager.getDocumentsDirectory().appendingPathComponent("\(id)")
  }
  
}
