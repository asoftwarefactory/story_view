import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';

enum LoadState { loading, success, failure }

enum Direction { up, down, left, right }

class VerticalDragInfo {
  bool cancel = false;

  Direction? direction;

  void update(double primaryDelta) {
    Direction tmpDirection;

    if (primaryDelta > 0) {
      tmpDirection = Direction.down;
    } else {
      tmpDirection = Direction.up;
    }

    if (direction != null && tmpDirection != direction) {
      cancel = true;
    }

    direction = tmpDirection;
  }
}

Future<int> calculateVideoLengthInSeconds(String pathFileOrUrl) async {
  final mediaInfo = (await FFprobeKit.getMediaInformation(pathFileOrUrl))
      .getMediaInformation();
  final dur = mediaInfo?.getDuration();
  if (dur != null) {
    final returnValue = double.tryParse(dur);
    if (returnValue != null) {
      return returnValue.round();
    } else {
      throw Exception(" mediaInfo?.getDuration() return value not valid");
    }
  } else {
    throw Exception("getDuration return null value , check pathFileOrUrl");
  }
}
