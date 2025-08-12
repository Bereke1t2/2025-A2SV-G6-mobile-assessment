import 'package:flutter/material.dart';
import 'package:chatting_app/Futures/chat/presentation/widgets/my_story.dart';
import 'package:chatting_app/Futures/chat/presentation/widgets/story.dart';
import 'package:chatting_app/core/ui/helper.dart';
import '../widgets/person_box.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage>
    with SingleTickerProviderStateMixin {
  double panelTop = 240; // collapsed start
  final double minTop = 0; // expanded
  final double maxTop = 240; // collapsed

  late AnimationController _animController;
  late Animation<double> _anim;
  bool draggingFromList = false;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  void animatePanel(double target) {
    _anim = Tween<double>(begin: panelTop, end: target).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {
          panelTop = _anim.value;
        });
      });

    _animController.forward(from: 0);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF498CF0),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white, size: 30),
            ),
          ),

          Positioned(
            top: 120,
            left: 0,
            right: 0,
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: List.generate(
                  10,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: index == 0
                        ? MyStory(

                            imageUrl:
                                'assets/images/${getRandomNumber(4)}.png',
                          )
                        : StoryWidget(
                            label: 'Person $index',
                            imageUrl:
                                'assets/images/${getRandomNumber(4)}.png',
                          ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: panelTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (!draggingFromList) {
                  setState(() {
                    panelTop += details.delta.dy;
                    panelTop = panelTop.clamp(minTop, maxTop);
                  });
                }
              },
              onVerticalDragEnd: (details) {
                if (!draggingFromList) {
                  if (panelTop < (maxTop + minTop) / 2) {
                    animatePanel(minTop);
                  } else {
                    animatePanel(maxTop);
                  }
                }
                draggingFromList = false;
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Handle
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      // Chat list
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is OverscrollNotification &&
                                notification.overscroll < 0 &&
                                panelTop == minTop) {
                              draggingFromList = true;
                              setState(() {
                                panelTop -= notification.overscroll;
                                panelTop = panelTop.clamp(minTop, maxTop);
                              });
                              return true;
                            }
                            return false;
                          },
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 20,
                            itemBuilder: (context, index) => PersonBox(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
