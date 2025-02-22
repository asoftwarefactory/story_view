import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

Future<void> main() async {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final StoryController controller = StoryController();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delicious Ghanaian Meals"),
      ),
      body: Container(
        margin: const EdgeInsets.all(
          8,
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 300,
              child: StoryView(
                activeSwipeDetect: true,
                startingIndex: 2,
                controller: controller,
                storyItems: [
                  StoryItem.text(
                    title:
                        "Hello world!\nHave a look at some great Ghanaian delicacies. I'm sorry if your mouth waters. \n\nTap!",
                    backgroundColor: Colors.orange,
                    roundedTop: true,
                    duration: const Duration(seconds: 9),
                  ),
                  // StoryItem.inlineImage(
                  //   NetworkImage(
                  //       "https://image.ibb.co/gCZFbx/Banku-and-tilapia.jpg"),
                  //   caption: Text(
                  //     "Banku & Tilapia. The food to keep you charged whole day.\n#1 Local food.",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       backgroundColor: Colors.black54,
                  //       fontSize: 17,
                  //     ),
                  //   ),
                  // ),
                  StoryItem.pageImage(
                    url:
                        "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
                    controller: controller,
                    /*  caption: const Text(
                      "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 17,
                      ),
                    ), */
                  ),
                  StoryItem.pageVideoCalculateDuration(
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                    controller: controller,
                    /*  caption: const Text(
                      "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 17,
                      ),
                    ), */
                  ),
                  StoryItem.pageVideo(
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                    controller: controller,
                    /*  caption: const Text(
                      "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 17,
                      ),
                    ), */
                  ),
                  StoryItem.inlineImage(
                    url:
                        "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
                    controller: controller,
                    caption: const Text(
                      "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  StoryItem.inlineImage(
                    url:
                        "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
                    controller: controller,
                    caption: const Text(
                      "Hektas, sektas and skatad",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
                onStoryShow: (s) {
                  debugPrint("Showing a story");
                },
                onComplete: () {
                  debugPrint("Completed a cycle");
                },
                progressPosition: ProgressPosition.top,
                repeat: false,
                inline: true,
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MoreStories1()));
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(8))),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "View more stories",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // default path video
                final duration = await calculateVideoLengthInSeconds(
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
                debugPrint("Duration Seconds => $duration");
              },
              child: const Text("calcola la durata del video in secondi"),
            ),
          ],
        ),
      ),
    );
  }
}

class MoreStories extends StatefulWidget {
  const MoreStories({super.key});

  @override
  MoreStoriesState createState() => MoreStoriesState();
}

class MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More"),
      ),
      body: StoryView(
        key: UniqueKey(),
        storyItems: [
          StoryItem.text(
            title: "I guess you'd love to see more of our food. That's great.",
            backgroundColor: Colors.blue,
            duration: const Duration(seconds: 9),
          ),
          StoryItem.text(
            title: "Nice!\n\nTap to continue.",
            backgroundColor: Colors.red,
            textStyle: const TextStyle(
              fontFamily: 'Dancing',
              fontSize: 40,
            ),
          ),
          StoryItem.pageImage(
            url:
                "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
            caption: "Still sampling",
            controller: storyController,
          ),
          StoryItem.pageImage(
            url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
            caption: "Working with gifs",
            controller: storyController,
          ),
          StoryItem.pageImage(
            url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
            caption: "Hello, from the other side",
            controller: storyController,
          ),
          StoryItem.pageImage(
            url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
            caption: "Hello, from the other side2",
            controller: storyController,
          ),
        ],
        onStoryShow: (s) {
          debugPrint("Showing a story");
        },
        onComplete: () {
          debugPrint("Completed a cycle");
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}

class MoreStories1 extends StatefulWidget {
  const MoreStories1({super.key});

  @override
  MoreStories1State createState() => MoreStories1State();
}

class MoreStories1State extends State<MoreStories1> {
  final storyController = StoryController();
  final pageController = PageController(initialPage: 1);
  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text("More"),
      ), */
      body: MultipleStoryView(
        pageController: pageController,
        buildViews: (PageController controller) {
          return [
            StoryView(
              storyItems: [
                StoryItem.text(
                  title:
                      "I guess you'd love to see more of our food. That's great.",
                  backgroundColor: Colors.blue,
                  duration: const Duration(seconds: 9),
                ),
                StoryItem.text(
                  title: "Nice!\n\nTap to continue.",
                  backgroundColor: Colors.blue,
                  textStyle: const TextStyle(
                    fontFamily: 'Dancing',
                    fontSize: 40,
                  ),
                ),
              ],
              controller: StoryController(),
              onComplete: () => controller.goToNextPage(),
            ),
            StoryView(
              storyItems: [
                StoryItem.text(
                  title:
                      "I guess you'd love to see more of our food. That's great.",
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 9),
                ),
                StoryItem.text(
                  title: "Nice!\n\nTap to continue.",
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(
                    fontFamily: 'Dancing',
                    fontSize: 40,
                  ),
                ),
              ],
              controller: StoryController(),
            ),
          ];
        },
      ),
    );
  }
}
