import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';


toas(BuildContext context, String txt) async {
  await showTextToast(
    text: txt,
    context: context,
  );
}

