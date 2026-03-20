/// Extension pada String untuk konversi Title Case
extension StringCasing on String {
  /// Mengubah string menjadi Title Case
  /// Contoh: 'fire dragon' → 'Fire Dragon'
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isEmpty
            ? word
            : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ');
  }
}
