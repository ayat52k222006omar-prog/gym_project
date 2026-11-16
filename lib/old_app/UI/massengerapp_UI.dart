import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfirstapp/old_app/API/const.dart';
import 'package:myfirstapp/old_app/UI/whatsapptextstyle.dart';
import 'package:myfirstapp/old_app/API/api_list.dart';
import 'package:myfirstapp/old_app/API/chat_model.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WhatsappChatsScreen(),
    ),
  );
}

class WhatsappChatsScreen extends StatelessWidget {
  const WhatsappChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(radius: 24, backgroundImage: NetworkImage(image1)),
                const SizedBox(width: 12),
                const Text(
                  "Chats",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(CupertinoIcons.camera, color: Colors.black),
                const SizedBox(width: 20),
                const Icon(Icons.search, color: Colors.black),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  icon: Icon(Icons.search),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 30,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 27,
                        backgroundImage: NetworkImage(image1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount:
                    apiChats.length, // عدلناها لتعتمد على حجم الليست الحقيقية
                itemBuilder: (context, index) {
                  // تحويل كل عنصر من الـ apiChats إلى ChatModel
                  final chat = ChatModel.fromJson(apiChats[index]);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _myChat(chat),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _myChat(ChatModel chat) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(radius: 25, backgroundImage: NetworkImage(chat.image ?? "")),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(chat.name ?? "", style: Whatsapptextstyle.titleTextStyle()),
          const SizedBox(height: 4),
          _messageBuilder(chat),
        ],
      ),
      const Spacer(),
      Text(chat.time ?? "", style: Whatsapptextstyle.msgTextStyle()),
    ],
  );
}

Widget _messageBuilder(ChatModel chat) {
  if (chat.messageType == ChatType.text) {
    return Text(chat.message ?? "", style: Whatsapptextstyle.msgTextStyle());
  } else if (chat.messageType == ChatType.video) {
    return Row(
      children: [
        const Icon(CupertinoIcons.video_camera, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text("Video", style: Whatsapptextstyle.msgTextStyle()),
      ],
    );
  } else {
    return Row(
      children: [
        const Icon(Icons.gif, size: 20, color: Colors.grey),
        const SizedBox(width: 4),
        Text("Gif", style: Whatsapptextstyle.msgTextStyle()),
      ],
    );
  }
}
