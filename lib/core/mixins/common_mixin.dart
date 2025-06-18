mixin CommonMixin {
  static String getNumberWithCommas(String amount) {
    if (amount.isEmpty) return '';
    return amount.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}
