import 'package:flutter/material.dart';
import 'colors.dart' as colors;

Widget userChatListTile(String name, String lastMessage, int status,
    NetworkImage image, String time) {
  int clipLen = 25;
  if (lastMessage.length > clipLen) {
    lastMessage = lastMessage.substring(0, clipLen) + "...";
  }
  return Column(
    children: [
      SizedBox(
        height: 80,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: image,
                ),
              ),
              Flexible(
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 19,
                          color: colors.foregroundText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 16,
                          color: colors.lowGrey,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        status != 0
                            ? SizedBox(
                                width: 26, child: statusCheckBanner(status))
                            : SizedBox(width: 0),
                        Expanded(
                          child: Text(
                            lastMessage,
                            style: TextStyle(
                              fontSize: 16,
                              color: colors.foregroundText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Row(
        children: [
          SizedBox(
            width: 72,
          ),
          Expanded(
            child: Divider(
              color: colors.lowGrey,
              thickness: 0.25,
              height: 10,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget testUserChatListTile = userChatListTile(
    "Jane Doe",
    "Test Message lolol Lorum Ipsum Test",
    1,
    NetworkImage(
        "https://images.unsplash.com/photo-1678961965142-819258296d0d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1336&q=80"),
    "12:00 PM");

Widget statusCheckBanner(int status) {
  // Status 0 -> recieved, 1 -> delivered, 2 -> read
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Positioned(
        left: 6,
        child: Icon(
          Icons.check,
          color: status == 1 ? colors.primaryHighlight : colors.lowGrey,
          size: 17,
        ),
      ),
      Icon(
        Icons.check,
        color: status == 1 ? colors.primaryHighlight : colors.lowGrey,
        size: 17,
      ),
    ],
  );
}

List<Widget> userChatList = [
  userChatListTile(
      "Daddy",
      "Sure daddy. I'll be home soon.",
      1,
      NetworkImage(
          "https://images.unsplash.com/photo-1678911020402-650375a7776a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80"),
      "11:32 AM"),
  userChatListTile(
      "Amma",
      "I'm going to the market. Do you want anything?",
      0,
      NetworkImage(
          "https://images.unsplash.com/photo-1679057783906-90bd5024133e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
      "10:48 AM"),
  userChatListTile(
    "Sis \u2764",
    "Get me chocolates",
    0,
    NetworkImage(
        "https://images.unsplash.com/photo-1679057657936-13c5ced340e2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
    "9:32 AM",
  ),
  userChatListTile(
    "Bro",
    "I'm taking your bike out for a spin. Don't worry, I'll be back soon.",
    1,
    NetworkImage(
        "https://images.unsplash.com/photo-1679076645080-571849829e49?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=988&q=80"),
    "9:32 AM",
  ),
  userChatListTile(
    "Zoya VIT",
    "Did you finish the assignment?",
    2,
    NetworkImage(
        "https://images.unsplash.com/photo-1679048978024-d8d7737d3920?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3706&q=80"),
    "9:32 AM",
  ),
  userChatListTile(
    "Ira VIT",
    "Let's order pizza tonight",
    0,
    NetworkImage(
        "https://images.unsplash.com/photo-1678789604892-595bd0868050?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=985&q=80"),
    "9:32 AM",
  ),
  userChatListTile(
    "Sara VIT",
    "Do you by any chance have a marker?",
    0,
    NetworkImage(
        "https://images.unsplash.com/photo-1675645387065-f66030ecd8bd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=985&q=80"),
    "9:32 AM",
  ),
];
