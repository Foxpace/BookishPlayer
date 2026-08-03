import Flutter
import MediaPlayer

final class CarPlayCatalogHost: NSObject, CarPlayHostApi,
  MPPlayableContentDataSource, MPPlayableContentDelegate
{
  private var books: [CarBookItem] = []
  private let flutterApi: CarPlayFlutterApi

  init(binaryMessenger: FlutterBinaryMessenger) {
    flutterApi = CarPlayFlutterApi(binaryMessenger: binaryMessenger)
    super.init()
    let manager = MPPlayableContentManager.shared()
    manager.dataSource = self
    manager.delegate = self
  }

  func updateLibrary(books: [CarBookItem]) throws {
    self.books = books
    MPPlayableContentManager.shared().reloadData()
  }

  func numberOfChildItems(at indexPath: IndexPath) -> Int {
    indexPath.count == 0 ? books.count : 0
  }

  func contentItem(at indexPath: IndexPath) -> MPContentItem? {
    guard indexPath.count == 1, indexPath.item < books.count else {
      return nil
    }
    let book = books[indexPath.item]
    let item = MPContentItem(identifier: book.id)
    item.title = book.title
    item.subtitle = book.author.isEmpty ? book.series : book.author
    item.isContainer = false
    item.isPlayable = true
    if book.durationMs > 0 {
      item.playbackProgress = Float(book.positionMs) / Float(book.durationMs)
    }
    return item
  }

  func playableContentManager(
    _ contentManager: MPPlayableContentManager,
    initiatePlaybackOfContentItemAt indexPath: IndexPath,
    completionHandler: @escaping (Error?) -> Void
  ) {
    guard indexPath.count == 1, indexPath.item < books.count else {
      completionHandler(
        NSError(
          domain: "BookishCarPlay",
          code: 1,
          userInfo: [NSLocalizedDescriptionKey: "Audiobook is unavailable"]
        )
      )
      return
    }
    flutterApi.playBook(id: books[indexPath.item].id) { result in
      switch result {
      case .success:
        completionHandler(nil)
      case .failure(let error):
        completionHandler(error)
      }
    }
  }
}
