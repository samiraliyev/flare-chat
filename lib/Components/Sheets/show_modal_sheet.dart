import 'package:flutter/material.dart';

final class AppSheets {
  static Future openSheet(BuildContext context, {Widget? child}) {
    return showModalBottomSheet(
        enableDrag: false,
        elevation: 0,
        barrierColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => child ?? const SizedBox());
  }
}
