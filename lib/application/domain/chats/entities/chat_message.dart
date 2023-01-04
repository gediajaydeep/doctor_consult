import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String type;
  final String message;
  final int time;

  const ChatMessage(
      {required this.type, required this.message, required this.time});

  @override
  List<Object?> get props => [type, message, time];
}
