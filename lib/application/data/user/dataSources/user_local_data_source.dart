import 'dart:convert';

import '../../../../core/dataManager/cached_data_manager.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final CachedDataManager _cachedDataManager;

  UserLocalDataSourceImpl({required CachedDataManager cachedDataManager})
      : _cachedDataManager = cachedDataManager;

  @override
  Future<UserModel> getUser() async {
    String? data = await _cachedDataManager.readCachedData(CachedDataType.user);
    if (data.isEmpty) {
      throw Exception('No Data found');
    }
    return UserModel.fromJson(
      jsonDecode(data),
    );
  }
}
