import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final bool isMe;
  final int index;
  const MessageBox({super.key, this.isMe = true, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: isMe ? 50.0 : 8.0,
        right: isMe ? 8.0 : 50.0,
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage('assets/images/${index % 3 + 1}.png'),
            ),
            const SizedBox(width: 8.0),
          ],
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  isMe ? 'You' : 'Them',
                  style: TextStyle(
                    color: isMe ? Color(0xFF000E08) : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blueAccent : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isMe ? 12.0 : 0.0),
                      topRight: Radius.circular(isMe ? 0.0 : 12.0),
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    'Message fnuefbwifb weeifbqefvieqf qvifqvfiq wifvqif qifqufhvqe fhv qieiqb fbsebdi wbefw vw efiwvfwevf wvy8fveq fwifv yqiv f  w fdqd dfqufiwefkniudbebfwqefiqbi fq qibdq wuf qifbqwfv qwifdsifaakefvw w vwviwebfqe evv ewiebviwub iwe ',
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 12.0,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '12:00 PM', // Example time
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8.0),
            CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage('assets/images/${index % 3 + 1}.png'),
            ),
          ],
        ],
      ),
    );
  }
}
