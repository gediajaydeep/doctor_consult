import 'package:equatable/equatable.dart';

import '../../doctors/entities/doctor.dart';
import '../../user/entities/user.dart';
import 'chat_message.dart';

class ChatList extends Equatable {
  final User sender;
  final Doctor receiver;
  final ChatMessage lastMessage;
  final int unReadMessageCount;

  const ChatList(
      this.sender, this.receiver, this.lastMessage, this.unReadMessageCount);

  @override
  List<Object?> get props => throw UnimplementedError();
}
