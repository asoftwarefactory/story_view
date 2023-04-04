import 'package:flutter/material.dart';

extension ExtPageController on PageController {
  int get currentPage {
    return page?.round() ?? 0;
  }

  Future<void> goToNextPage({
    Duration duration = const Duration(seconds: 1),
    Curve curve = Curves.ease,
    VoidCallback? onNextPage,
  }) async {
    if (currentPage >= 0) {
      await animateToPage(
        currentPage + 1,
        duration: duration,
        curve: curve,
      );
      onNextPage?.call();
    }
  }

  Future<void> goToPreviousPage({
    Duration duration = const Duration(seconds: 1),
    Curve curve = Curves.ease,
    VoidCallback? onPreviousPage,
  }) async {
    if (currentPage > 0) {
      await animateToPage(
        currentPage - 1,
        duration: duration,
        curve: curve,
      );
      onPreviousPage?.call();
    }
  }
}
