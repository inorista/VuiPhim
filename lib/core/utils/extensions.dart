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
