import 'package:consultations_app_test/application/domain/chats/entities/chat_list.dart';
import 'package:consultations_app_test/core/theme/app_theme.dart';
import 'package:consultations_app_test/core/utils/date_time_extensions.dart';
import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final ChatList chatItem;

  const ChatListItem({super.key, required this.chatItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
          child: Row(
            children: [
              _receiverImage(chatItem.receiver.image),
              const SizedBox(
                width: 12,
              ),
              _messageDetails(context, chatItem.receiver.name,
                  chatItem.lastMessage.message),
              const SizedBox(
                width: 12,
              ),
              _unreadMessageAndTime(context, chatItem.lastMessage.time,
                  chatItem.unReadMessageCount)
            ],
          ),
        ),
      ),
    );
  }

  _receiverImage(String? image) {
    return Center(
      child: SizedBox(
        height: 54,
        width: 54,
        child: CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.2),
          child: ClipOval(
            child: Image.network(image ?? ''),
          ),
        ),
      ),
    );
  }

  _messageDetails(BuildContext context, String? name, String message) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name ?? '',
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: AppTheme.greyDark),
          ),
        ],
      ),
    );
  }

  _unreadMessageAndTime(
      BuildContext context, int time, int unReadMessageCount) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          DateTime.fromMillisecondsSinceEpoch(time).format('hh.mm a'),
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: AppTheme.greyDark),
        ),
        const SizedBox(
          height: 8,
        ),
        (unReadMessageCount == 0)
            ? const SizedBox()
            : Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.appBlue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    unReadMessageCount.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white, fontSize: 10),
                  ),
                ),
              )
      ],
    );
  }
}
