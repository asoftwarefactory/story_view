import 'package:flutter/material.dart';
import 'package:story_view/extensions/page_controller.dart';
import 'story_view.dart';

class MultipleStoryView extends StatefulWidget {
  final List<StoryView> Function(PageController controller) buildViews;
  final void Function(StoryView indexStory)? onStoryChanged;
  final int startingIndex;
  final PageController? pageController;
  const MultipleStoryView({
    Key? key,
    this.startingIndex = 0,
    required this.buildViews,
    this.onStoryChanged,
    this.pageController,
  }) : super(key: key);

  @override
  State<MultipleStoryView> createState() => _MultipleStoryViewState();
}

class _MultipleStoryViewState extends State<MultipleStoryView> {
  late final _controller = widget.pageController ??
      PageController(initialPage: widget.startingIndex);
  late final views = widget.buildViews(_controller);

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
    return SizedBox.expand(
      // FIX: Solution to fix PageView scrolling
      child: Listener(
        onPointerMove: (moveEvent) {
          if (moveEvent.delta.dx > 0) {
            debugPrint("swipe right");
            _controller.goToPreviousPage();
          } else if (moveEvent.delta.dx < 0) {
            debugPrint("swipe left");
            _controller.goToNextPage();
          }
        },
        child: PageView.builder(
          allowImplicitScrolling: true,
          controller: _controller,
          itemCount: views.length,
          itemBuilder: (ctx, index) {
            return views.elementAt(index);
          },
          onPageChanged: (i) {
            widget.onStoryChanged?.call(views.elementAt(i));
          },
        ),
      ),
    );
  }
}
