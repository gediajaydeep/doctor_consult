import 'package:consultations_app_test/application/domain/chats/entities/chat_message.dart';

class ChatMessageModel {
  String? type;
  String? message;
  int? time;

  ChatMessageModel({this.type, this.message, this.time});

  ChatMessage toChatMessage() {
    return ChatMessage(type: type!, message: message ?? '', time: time!);
  }
}
