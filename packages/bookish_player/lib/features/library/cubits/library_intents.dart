typedef PrepareBookRemoval = Future<void> Function(String bookId);

enum BookAction {
  toggleFavorite,
  wantToListen,
  markFinished,
  markUnfinished,
  useProgressStatus,
  viewFullTitle,
  editMetadata,
  removeFromDevice,
}
