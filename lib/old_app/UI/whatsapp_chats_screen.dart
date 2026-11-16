import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/old_app/API/chat_model.dart';
import 'package:myfirstapp/old_app/UI/whatsapptextstyle.dart';
import 'package:myfirstapp/old_app/API/api_list.dart';

class WhatsappChatsScreen extends StatelessWidget {
  const WhatsappChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatModel> chats = apiChats.map((e) => ChatModel.fromJson(e)).toList();
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        child: const Icon(Icons.message, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: chats.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, i) => _myChat(chats[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.green,
      title: const Text("WhatsApp", style: TextStyle(color: Colors.white)),
      centerTitle: false,
      actions: const [
        Icon(CupertinoIcons.camera, color: Colors.white),
        SizedBox(width: 20),
        Icon(Icons.search, color: Colors.white),
        SizedBox(width: 20),
        Icon(Icons.more_vert, color: Colors.white),
        SizedBox(width: 20),
      ],
    );
  }

  Widget _myChat(ChatModel chat) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(chat.image ?? ""),
        ),
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
        Text("Video", style: Whatsapptextstyle.msgTextStyle()), // الأقواس محطوطة صح ومفيش const بره
      ],
    );
  }
  else {
    return Row( 
      children: [
        const Icon(Icons.gif, size: 20, color: Colors.grey),
        const SizedBox(width: 4),
        Text("Gif", style: Whatsapptextstyle.msgTextStyle()), // لازم تحط الأقواس () هنا كمان زي اختها
      ],
    );
  }
    }
  }
