import 'package:flutter/material.dart';
import '../../../../core/ui/helper.dart';
import 'person.dart';

class PersonBox extends StatelessWidget {
  final String? profileImage;
  final String? profileName;
  final String? lastMessage;
  final String? lastMessageTime;
  final String? unreadMessages;

  const PersonBox({
    super.key,
    this.profileImage,
    this.profileName,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadMessages,
  });

  @override
  Widget build(BuildContext context) {
    final String defaultProfileImage = 'assets/images/${getRandomNumber(4)}.png';
    final String defaultProfileName = 'Person Name ${getRandomNumber(100)}';
    final String defaultLastMessage = 'Last message preview ${getRandomNumber(100)}';
    final String defaultLastMessageTime = '${getRandomNumber(60)} min ago';
    final String defaultUnreadMessages = '${getRandomNumber(10)}';

    final String displayProfileImage = profileImage ?? defaultProfileImage;
    final String displayProfileName = profileName ?? defaultProfileName;
    final String displayLastMessage = lastMessage ?? defaultLastMessage;
    final String displayLastMessageTime = lastMessageTime ?? defaultLastMessageTime;
    final String displayUnreadMessages = unreadMessages ?? defaultUnreadMessages;

    return Container(
      height: 80.0,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Person(displayProfileImage: displayProfileImage), // Using the Person widget
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayProfileName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  fontFamily: "General Sans Variable",
                ),
              ),
              Text(
                '${displayLastMessage}...',
                style: const TextStyle(
                  color: Color(0xFF797C7B),
                  fontSize: 12.0,
                  fontFamily: "General Sans Variable",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                displayLastMessageTime,
                style: const TextStyle(
                  color: Color(0xFF797C7B),
                  fontSize: 12.0,
                  fontFamily: "General Sans Variable",
                ),
              ),
              const SizedBox(height: 4.0),
              if (displayUnreadMessages != '0') ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF3F51F3),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    displayUnreadMessages,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}