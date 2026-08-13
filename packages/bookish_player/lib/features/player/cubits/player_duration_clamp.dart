extension PlayerDurationClamp on Duration {
  Duration clampedTo(Duration maximum) {
    if (this < Duration.zero) {
      return Duration.zero;
    }
    if (maximum > Duration.zero && this > maximum) {
      return maximum;
    }
    return this;
  }
}
