
import 'package:flutter/material.dart';
class ResponsiveUtils {
  static double scale(BuildContext context, double value) {
    return value * MediaQuery.of(context).size.width / 375;
  }
}
