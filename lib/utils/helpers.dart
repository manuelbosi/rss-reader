String stripHtml(String string) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);
  return string.replaceAll(exp, '').replaceAll('&nbsp;', '').trim();
}
