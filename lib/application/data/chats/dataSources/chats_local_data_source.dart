import 'dart:convert';

import 'package:consultations_app_test/application/data/chats/models/chat_message_model.dart';
import 'package:consultations_app_test/core/dataManager/cached_data_manager.dart';

import '../../doctors/models/doctor_model.dart';
import '../../user/models/user_model.dart';
import '../models/chat_list_model.dart';

abstract class ChatsLocalDataSource {
  Future<List<ChatListModel>> getChatList();
}

class ChatsLocalDataSourceImpl implements ChatsLocalDataSource {
  final CachedDataManager _cachedDataManager;

  ChatsLocalDataSourceImpl(this._cachedDataManager);

  @override
  Future<List<ChatListModel>> getChatList() async {
    UserModel user = await _getUserFromJsonFile();
    List<DoctorModel> doctorsList = await _getDoctorListFromJsonFile();
    List<ChatListModel> list = (await _getChatsFromJsonFile()).map(
      (_ChatFileModel e) {
        return ChatListModel(
            sender: user,
            receiver: doctorsList.firstWhere(
              (element) => (element.id == e.receiver),
            ),
            lastMessage: ChatMessageModel(
                type: e.lastMessage!.type,
                message: e.lastMessage!.message,
                time: e.lastMessage!.time),
            unreadMessageCount: e.unreadMessageCount);
      },
    ).toList();
    return list;
  }

  Future<List<_ChatFileModel>> _getChatsFromJsonFile() async {
    String? appointments =
        await _cachedDataManager.readCachedData(CachedDataType.chats);
    if (appointments.isEmpty) {
      throw Exception('No Data found');
    }
    Iterable iterable = jsonDecode(appointments);

    List<_ChatFileModel> set = List.from(
      iterable.map(
        (e) => _ChatFileModel.fromJson(e),
      ),
    );
    return set;
  }

  Future<List<DoctorModel>> _getDoctorListFromJsonFile() async {
    String? data =
        await _cachedDataManager.readCachedData(CachedDataType.doctors);
    if (data.isEmpty) {
      throw Exception('No Data found');
    }
    Iterable iterable = jsonDecode(data);

    List<DoctorModel> list = List<DoctorModel>.from(
      iterable.map(
        (element) => DoctorModel.fromJson(element),
      ),
    );
    return list;
  }

  _getUserFromJsonFile() async {
    String? data = await _cachedDataManager.readCachedData(CachedDataType.user);
    if (data.isEmpty) {
      throw Exception('No Data found');
    }
    return UserModel.fromJson(
      jsonDecode(data),
    );
  }
}

class _ChatFileModel {
  int? sender;
  int? receiver;
  _ChatFileMessage? lastMessage;
  int? unreadMessageCount;

  _ChatFileModel.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    receiver = json['receiver'];
    lastMessage = json['lastMessage'] != null
        ? _ChatFileMessage.fromJson(json['lastMessage'])
        : null;
    unreadMessageCount = (json['unreadMessageCount'] as num?)?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender'] = sender;
    data['receiver'] = receiver;
    data['unreadMessageCount'] = unreadMessageCount;
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage!.toJson();
    }
    return data;
  }
}

class _ChatFileMessage {
  String? type;
  String? message;
  int? time;

  _ChatFileMessage.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    data['time'] = time;
    return data;
  }
}
