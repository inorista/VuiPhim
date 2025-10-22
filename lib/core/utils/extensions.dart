extension FirstOrDefault<T> on Iterable<T> {
  T? firstOrDefault([bool Function(T element)? test]) {
    if (test == null) {
      return isEmpty ? null : first;
    }
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

extension FormatDuration on Duration {
  String toFormattedString() {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
}

extension FormatDateFromMilliseconds on int {
  String toDateString() {
    final duration = Duration(milliseconds: this);
    final String hours = duration.inHours.toString().padLeft(2, '0');

    final String minutes = duration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    final String secondsFormatted = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return '$hours:$minutes:$secondsFormatted';
  }
}
