import 'package:flutter/material.dart';
import 'story_view.dart';

class MultipleStoryView extends StatefulWidget {
  final List<StoryView> Function(PageController controller) buildViews;
  final int startingIndex;
  const MultipleStoryView({
    Key? key,
    this.startingIndex = 0,
    required this.buildViews,
  }) : super(key: key);

  @override
  State<MultipleStoryView> createState() => _MultipleStoryViewState();
}

class _MultipleStoryViewState extends State<MultipleStoryView> {
  late final _controller = PageController(initialPage: widget.startingIndex);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: widget.buildViews(_controller),
    );
  }
}
