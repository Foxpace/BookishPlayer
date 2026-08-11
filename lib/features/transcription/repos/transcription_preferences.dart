abstract interface class TranscriptionPreferences {
  Future<String?> getSelectedModel();
  Future<void> setSelectedModel(String model);
}
