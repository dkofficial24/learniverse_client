import 'dart:ui' as ui;

class PlatformViewRegistry {
  static void registerViewFactory(String viewId, dynamic cb) {
    cb.platformViewRegistry.registerViewFactory(viewId, cb);
  }
}
