import 'package:flutter/material.dart';
import 'story_view.dart';

class MultipleStoryView extends StatefulWidget {
  final List<StoryView> Function(
    PageController controller,
    Future<void> Function(VoidCallback? onNextPage) nextPage,
    Future<void> Function(VoidCallback? onPrevousPage) prevousPage,
  ) buildViews;
  final void Function(StoryView indexStory)? onStoryChanged;
  final int startingIndex;
  const MultipleStoryView({
    Key? key,
    this.startingIndex = 0,
    required this.buildViews,
    this.onStoryChanged,
  }) : super(key: key);

  @override
  State<MultipleStoryView> createState() => _MultipleStoryViewState();
}

class _MultipleStoryViewState extends State<MultipleStoryView> {
  late final _controller = PageController(initialPage: widget.startingIndex);
  late final views =
      widget.buildViews(_controller, _goToNextPage, _goToPreviousPage);
  late int _currentIndex = _controller.initialPage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _goToNextPage(VoidCallback? onNextPage) async {
    if (_currentIndex >= 0) {
      await _controller.animateToPage(_currentIndex + 1,
          duration: Duration.zero, curve: Curves.ease);
      onNextPage?.call();
    }
  }

  Future<void> _goToPreviousPage(VoidCallback? onPreviousPage) async {
    if (_currentIndex > 0) {
      await _controller.animateToPage(_currentIndex - 1,
          duration: Duration.zero, curve: Curves.ease);
      onPreviousPage?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: views.length,
      itemBuilder: (ctx, index) {
        return views.elementAt(index);
      },
      onPageChanged: (i) {
        _currentIndex = i;
        widget.onStoryChanged?.call(views.elementAt(i));
      },
    );
  }
}
