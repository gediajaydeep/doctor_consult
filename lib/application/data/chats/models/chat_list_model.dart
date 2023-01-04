import 'package:consultations_app_test/application/data/user/models/user_model.dart';
import 'package:consultations_app_test/application/domain/chats/entities/chat_list.dart';

import '../../doctors/models/doctor_model.dart';
import 'chat_message_model.dart';

class ChatListModel {
  UserModel? sender;
  DoctorModel? receiver;
  ChatMessageModel? lastMessage;
  int? unreadMessageCount;

  ChatListModel(
      {this.sender, this.receiver, this.lastMessage, this.unreadMessageCount});

  ChatList toChatList() {
    return ChatList(sender!.toUser(), receiver!.toDoctor(),
        lastMessage!.toChatMessage(), unreadMessageCount ?? 0);
  }
}
