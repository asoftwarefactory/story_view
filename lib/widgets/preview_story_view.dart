/* import 'package:flutter/material.dart';
import 'story_item.dart';
import 'story_view.dart';

class PreviewStoryView extends StatelessWidget {
  final StoryView storyView;
  final Widget Function(StoryItem item) onStoryBuild;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool shrinkWrap;
  final void Function(BuildContext ctx, StoryItem item)? onStoryTap;
  const PreviewStoryView({
    Key? key,
    required this.storyView,
    required this.onStoryBuild,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.controller,
    this.shrinkWrap = false,
    this.onStoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      physics: physics,
      controller: controller,
      shrinkWrap: shrinkWrap,
      itemCount: storyView.storyItems.length,
      itemBuilder: (ctx, index) {
        final element = storyView.storyItems.elementAt(index);
        return GestureDetector(
          onTap: () => onStoryTap?.call(ctx, element),
          child: onStoryBuild(element),
        );
      },
    );
  }
}
 */