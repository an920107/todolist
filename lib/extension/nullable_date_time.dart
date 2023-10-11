extension NullableDateTime on DateTime? {
  int compareToNullable(DateTime? other) {
    if (this == null && other == null) {
      return 0;
    } else if (this == null && other != null) {
      return 1;
    } else if (this != null && other == null) {
      return -1;
    } else {
      return this!.compareTo(other!);
    }
  }
}
