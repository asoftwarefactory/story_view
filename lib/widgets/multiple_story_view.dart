import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'story_view.dart';

class MultipleStoryView extends StatefulWidget {
  final List<StoryView> Function(PageController controller) buildViews;
  final void Function(StoryView indexStory)? onStoryChanged;
  final int startingIndex;
  final PageController? pageController;
  final bool expand;
  const MultipleStoryView({
    Key? key,
    this.startingIndex = 0,
    required this.buildViews,
    this.onStoryChanged,
    this.pageController,
    this.expand = false,
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
    if (widget.expand) {
      return SizedBox.expand(child: _buildWidget(context));
    } else {
      return _buildWidget(context);
    }
  }

  Widget _buildWidget(BuildContext context) {
    // FIX: Solution to fix PageView scrolling
    return RawGestureDetector(
      gestures: {
        AllowMultipleHorizontalScrollGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<
                AllowMultipleHorizontalScrollGestureRecognizer>(
          () => AllowMultipleHorizontalScrollGestureRecognizer(),
          (AllowMultipleHorizontalScrollGestureRecognizer instance) {
            instance.onUpdate = (details) {
              // Calcola la distanza orizzontale e verticale dello spostamento
              final double dx = details.delta.dx.abs();
              final double dy = details.delta.dy.abs();
              // Controlla se la direzione dello spostamento è orizzontale
              if (dx > dy) {
                // Se la direzione è orizzontale, chiama il metodo onPanUpdate
                // del PageController per scorrere le pagine
                // PageController controller = PageController();
                /* _controller = PageController(initialPage: controller);
                controller.onPageChanged = (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                }; */
                _controller
                    .jumpTo((_controller.offset - (details.delta.dx + 2.5)));
              } else {
                // Se la direzione non è orizzontale, lascia che RawGestureDetector gestisca l'evento
                return;
              }
            };
          },
        ),
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
    );
  }
}

class AllowMultipleHorizontalScrollGestureRecognizer
    extends HorizontalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
