class ChatModel {
  int? id;
  String? name;
  String? message;
  String? time;
  String? image;
  ChatType? messageType;

  ChatModel.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    name = json["name"];
    message = json["message"];
    time = json["time"];
    image = json["image"];
    // حطينا علامات الاستفهام والـ ?? عشان لو راجع null ما يضربش
    messageType = getChatType(json["message_type"] ?? json["message_Type"]);
  }
}

enum ChatType { text, video, gif }

// عدلنا الـ String هنا وخليناها String? عشان تقبل الـ null بالأمان
ChatType getChatType(String? chattype) {
  if (chattype == null) return ChatType.text; // لو فاضية اعتبرها نص عادى
  
  switch (chattype.toLowerCase()) {
    case "text":
      return ChatType.text;
    case "video":
      return ChatType.video;
    case "gif":
      return ChatType.gif;
    default:
      return ChatType.text;
  }
}