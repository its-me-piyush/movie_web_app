import 'package:flutter/material.dart';

import 'constants.dart';


// ████████╗██╗░░██╗███████╗███╗░░░███╗███████╗
// ╚══██╔══╝██║░░██║██╔════╝████╗░████║██╔════╝
// ░░░██║░░░███████║█████╗░░██╔████╔██║█████╗░░
// ░░░██║░░░██╔══██║██╔══╝░░██║╚██╔╝██║██╔══╝░░
// ░░░██║░░░██║░░██║███████╗██║░╚═╝░██║███████╗
// ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚═╝░░░░░╚═╝╚══════╝

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: mwaBgColor,
    fontFamily: "Acumin",
    primarySwatch: MaterialColor(const Color(0xFF191B1E).value, const {
      50: Color(0xFFf1f2f3),
      100: Color(0xFFd5d8dc),
      200: Color(0xFFb9bec5),
      300: Color(0xFF9ea4ae),
      400: Color(0xFF828a97),
      500: Color(0xFF68717d),
      600: Color(0xFF515861),
      700: Color(0xFF3a3f46),
      800: Color(0xFF23262a),
      900: Color(0xFF0c0d0e),
    }),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
