import 'package:chatting_app/Futures/chat/presentation/widgets/my_story.dart';
import 'package:chatting_app/Futures/chat/presentation/widgets/story.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app/core/ui/helper.dart';

import '../widgets/person_box.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF498CF0),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 50.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.white, size: 30),
            ),
          ),
          // Header stories
          Padding(
            padding: const EdgeInsets.only(top: 110.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MyStory(imageUrl: 'assets/images/${getRandomNumber(4)}.png'),
                  const SizedBox(width: 20),
                  Story(imageUrl: 'assets/images/${getRandomNumber(4)}.png'),
                  const SizedBox(width: 20),
                  Story(imageUrl: 'assets/images/${getRandomNumber(4)}.png'),
                  const SizedBox(width: 20),
                  Story(imageUrl: 'assets/images/${getRandomNumber(4)}.png'),
                  const SizedBox(width: 20),
                  Story(imageUrl: 'assets/images/${getRandomNumber(4)}.png'),
                  const SizedBox(width: 20),
                  Story(imageUrl: 'assets/images/${getRandomNumber(4)}.png'),
                  const SizedBox(width: 20),
                  Story(imageUrl: 'assets/images/${getRandomNumber(4)}.png'),
                  const SizedBox(width: 20),
                  Story(imageUrl: 'assets/images/${getRandomNumber(4)}.png'),
                  const SizedBox(width: 20),
                  Story(imageUrl: 'assets/images/${getRandomNumber(4)}.png'),
                  const SizedBox(width: 20),
                  Story(imageUrl: 'assets/images/${getRandomNumber(4)}.png'),
                ],
              ),
            ),
          ),
          // Chats section
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: isExpanded ? 0 : 180,
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < -10) {
                  setState(() {
                    isExpanded = true;
                  });
                } else if (details.primaryDelta! > 10) {
                  setState(() {
                    isExpanded = false;
                  });
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Slide icon
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Center(
                          child: Icon(
                            Icons.remove,
                            size: 32,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      // Chats list
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return PersonBox();
                          },
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
