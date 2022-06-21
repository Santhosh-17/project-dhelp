import 'package:d_help/pages/prevention.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  Map<String, WidgetBuilder> routes() {
    return {
      Prevention.id: (context) => Prevention(),
    };
  }
}