import 'dart:convert';

import '../../../../core/dataManager/cached_data_manager.dart';
import '../models/doctor_model.dart';

abstract class DoctorsLocalDataSource {
  Future<List<DoctorModel>> getDoctorsList();

  Future<List<DoctorModel>> getTopDoctorsList();

  Future<DoctorModel> getDoctorDetails(int id);
}

class DoctorsLocalDataSourceImpl implements DoctorsLocalDataSource {
  final CachedDataManager cachedDataManager;

  DoctorsLocalDataSourceImpl({required CachedDataManager cahcedDataManager})
      : cachedDataManager = cahcedDataManager;

  @override
  Future<DoctorModel> getDoctorDetails(int id) async {
    List<DoctorModel> list = await _getListFromJsonFile();
    return list.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<DoctorModel>> getDoctorsList() async {
    return _getListFromJsonFile();
  }

  @override
  Future<List<DoctorModel>> getTopDoctorsList() async {
    List<DoctorModel> list = await _getListFromJsonFile();
    list.sort(
      (a, b) => (b.ratings ?? 0).compareTo(
        (a.ratings ?? 0),
      ),
    );
    return list;
  }

  Future<List<DoctorModel>> _getListFromJsonFile() async {
    String? data =
        await cachedDataManager.readCachedData(CachedDataType.doctors);
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
}
