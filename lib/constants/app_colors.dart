part of constants;

class AppColors {
  static const Color primaryColor = Color.fromRGBO(154, 116, 84, 1);
  static const Color secondaryColor = Colors.white;
  static const Color accentColor = Color.fromRGBO(238, 154, 47, 1);
  static const Color accentColor2 = Color.fromRGBO(166, 112, 97, 1);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFD8D9DA);
  static const Color grey100 = Color(0xFFEBEBEB);
  static const Color grey200 = Color(0xFFE3E3E3);
  static const Color grey300 = Color(0xFFB6B7B9);
  static const Color grey250 = Color(0xFFCACBCD);

  static const Color grey400 = Color(0xFFBEBEBE);
  static const Color grey450 = Color(0xFFB7B8BD);

  static const Color cream = Color(0xFFEBEBEC);
  static const Color cream500 = Color(0xFFC7C9CA);
  static const Color fadedGrey = Color(0xFF7B8186);
  static const Color cream700 = Color(0xFFB5B8BC);
//  static const Color cream700 = Color(0xFFB5B8BC);

  static const Color deepBlue100 = Color(0xFF5F6E80);
  static const Color deepBlue200 = Color(0xFF546478);
  static const Color deepBlue250 = Color(0xFF566C7F);

  static const Color deepBlue450 = Color(0xFF303E48);
  static const Color deepBlue500 = Color(0xFF000B2D);
  static const Color deepBlue700 = Color(0xFF141A21);
  static const Color deepBlue800 = Color(0xFF242D36);
  static const Color deepBlue900 = Color(0xFF020A13);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
