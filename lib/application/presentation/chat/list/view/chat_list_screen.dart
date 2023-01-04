import 'package:consultations_app_test/application/presentation/chat/list/view/widgets/chat_list_item.dart';
import 'package:consultations_app_test/application/presentation/chat/list/view/widgets/chat_screen_search_bar.dart';
import 'package:consultations_app_test/application/presentation/chat/list/viewModel/chat_list_view_model.dart';
import 'package:consultations_app_test/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatListScreenState();
  }
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void didChangeDependencies() {
    context.read<ChatListViewModel>().init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: AppTheme.scaffoldBackgroundColor,
          title: Text(
            'Chat',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
          child: Row(
            children: [
              Expanded(
                child: ChatScreenSearchBar(
                  onSearchChanged: (text) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: _editButton(),
              )
            ],
          ),
        ),
        Expanded(
          child: Consumer<ChatListViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (viewModel.chatList == null || viewModel.chatList!.isEmpty) {
                return const Center(
                  child: Text('No Chats Available'),
                );
              }
              return ListView.builder(
                itemCount: viewModel.chatList!.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return ChatListItem(chatItem: viewModel.chatList![index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  _editButton() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: const Padding(
        padding: EdgeInsets.all(14.0),
        child: Icon(
          Icons.edit_note,
          color: AppTheme.greyExtraDark,
        ),
      ),
    );
  }
}
