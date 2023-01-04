import 'dart:convert';

enum CachedDataType { doctors, user, appointments, chats }

class CachedDataManager {
  late String _doctorsData;
  late String _userData;
  late String _appointmentsData;
  late String _chatsData;

  CachedDataManager() {
    _doctorsData = _getDefaultDoctorListString();
    _userData = _getDefaultUserString();
    _appointmentsData = _getDefaultAppointmentString();
    _chatsData = _getDefaultChatListString();
  }

  Future<String> readCachedData(CachedDataType type) async {
    await Future.delayed(
      const Duration(milliseconds: 10),
    );
    switch (type) {
      case CachedDataType.doctors:
        return _doctorsData;
      case CachedDataType.user:
        return _userData;
      case CachedDataType.appointments:
        return _appointmentsData;
      case CachedDataType.chats:
        return _chatsData;
      default:
        return '';
    }
  }

  void saveDataToCache(CachedDataType type, String data) async {
    await Future.delayed(
      const Duration(milliseconds: 10),
    );
    switch (type) {
      case CachedDataType.doctors:
        _doctorsData = data;
        break;
      case CachedDataType.user:
        _userData = data;
        break;
      case CachedDataType.appointments:
        _appointmentsData = data;
        break;
      case CachedDataType.chats:
        _chatsData = data;
        break;
      default:
        return;
    }
  }

  String _getDefaultDoctorListString() {
    return jsonEncode([
      {
        "id": 1,
        "name": "dr. Kabuto Yashuki",
        "specialization": "Heart Specialist",
        "totalReviews": 153,
        "ratings": 4.8,
        "image":
            "https://www.freepnglogos.com/uploads/doctor-png/doctor-ufe-foccupation-pinterest-boy-cards-19.png",
        "description":
            "Dr  Kabuto  Yashuki is well known specialist in the field of Heart. He has a lot of experience and brings latest technologies for the diagnosis. He has successfully completed more than 250 heart operations.",
        "experience": 10,
        "totalPatients": 1026,
        "schedule": {
          "sunday": {},
          "monday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "tuesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "wednesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "thursday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "friday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "saturday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          }
        }
      },
      {
        "id": 2,
        "name": "dr. Ino Yamanaka",
        "specialization": "Dental Specialist",
        "totalReviews": 145,
        "ratings": 4.5,
        "image":
            "https://www.freepnglogos.com/uploads/doctor-png/doctor-png-transparent-doctor-images-pluspng-10.png",
        "description":
            "Dr Ino has good experience in dental field and has very good skills, She has performed Many surgeries, she is a root canal specialist",
        "experience": 5,
        "totalPatients": 500,
        "schedule": {
          "sunday": {},
          "monday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "tuesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "wednesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "thursday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "friday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "saturday": {
            "availableSlots": [9, 10, 11, 12, 13]
          }
        }
      },
      {
        "id": 3,
        "name": "dr. Orchimaru",
        "specialization": "Neuro Specialist",
        "totalReviews": 15,
        "ratings": 3.5,
        "image":
            "https://www.freepnglogos.com/uploads/doctor-png/doctor-clinic-and-patient-management-online-invoices-24.png",
        "description":
            "Dr Orchimaru has good experience in neuro field and has very good skills, He has performed Many surgeries, He is a migrane specialist",
        "experience": 2,
        "totalPatients": 100,
        "schedule": {
          "sunday": {"availableSlots": []},
          "monday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "tuesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "wednesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "thursday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "friday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "saturday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          }
        }
      },
      {
        "id": 4,
        "name": "dr. Kojiro Hyuga",
        "specialization": "ENT Specialist",
        "totalReviews": 98,
        "ratings": 2.7,
        "image":
            "https://www.freepnglogos.com/uploads/doctor-png/doctor-ufe-foccupation-pinterest-boy-cards-19.png",
        "description":
            "Dr Kojiro Hyuga is ent surgen who is well known for his ENT skills, he will help you well with your isues",
        "experience": 3,
        "totalPatients": 105,
        "schedule": {
          "sunday": {"availableSlots": []},
          "monday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "tuesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "wednesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "thursday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "friday": {
            "availableSlots": [9, 10, 11, 12, 16, 17, 18, 19]
          },
          "saturday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          }
        }
      },
      {
        "id": 5,
        "name": "dr. Benjamin Mullet",
        "specialization": "ENT Specialist",
        "totalReviews": 30,
        "ratings": 4.1,
        "image":
            "https://www.freepnglogos.com/uploads/doctor-png/doctor-clinic-and-patient-management-online-invoices-24.png",
        "description":
            "Dr Benjamin is a new in the field of ENT and he has excellent skills with gold medal from national health university and all the patients say that he is very ver good",
        "experience": 1,
        "totalPatients": 70,
        "schedule": {
          "sunday": {},
          "monday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "tuesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "wednesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "thursday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "friday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "saturday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          }
        }
      },
      {
        "id": 6,
        "name": "dr. Adam John",
        "specialization": "Gynecologist",
        "totalReviews": 250,
        "ratings": 4.0,
        "image":
            "https://www.freepnglogos.com/uploads/doctor-png/doctor-ufe-foccupation-pinterest-boy-cards-19.png",
        "description":
            "Dr Adam John is a well known gynec who is praised by his patients He has 8 years of experience in the field and can help you very nicely",
        "experience": 8,
        "totalPatients": 350,
        "schedule": {
          "sunday": {},
          "monday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "tuesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "wednesday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "thursday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "friday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          },
          "saturday": {
            "availableSlots": [9, 10, 11, 12, 13, 16, 17, 18, 19]
          }
        }
      }
    ]);
  }

  String _getDefaultUserString() {
    return jsonEncode({
      "id": 1,
      "name": "Luke",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStz-7qPNUOGtaXtVKfgKQXJ5oeGg0xpXMooIBnhTHjjqjOJbX5&s"
    });
  }

  String _getDefaultAppointmentString() {
    return jsonEncode([]);
  }

  String _getDefaultChatListString() {
    return jsonEncode(
      [
        {
          "sender": 1,
          "receiver": 1,
          "unreadMessageCount": 0,
          "lastMessage": {
            "type": "RECEIVED",
            "message": "Ready for visit?",
            "time": 1672547400000,
          },
        },
        {
          "sender": 1,
          "receiver": 2,
          "unreadMessageCount": 0,
          "lastMessage": {
            "type": "RECEIVED",
            "message": "Get well soon",
            "time": 1672551000000,
          },
        },
        {
          "sender": 1,
          "receiver": 3,
          "unreadMessageCount": 2,
          "lastMessage": {
            "type": "RECEIVED",
            "message": "Take your medicines",
            "time": 1672558200000,
          },
        },
        {
          "sender": 1,
          "receiver": 4,
          "unreadMessageCount": 0,
          "lastMessage": {
            "type": "RECEIVED",
            "message": "Thank you for the visit",
            "time": 1672569000000,
          },
        },
        {
          "sender": 1,
          "receiver": 5,
          "unreadMessageCount": 2,
          "lastMessage": {
            "type": "RECEIVED",
            "message": "Your reports are here",
            "time": 1672572600000,
          },
        },
        {
          "sender": 1,
          "receiver": 6,
          "unreadMessageCount": 2,
          "lastMessage": {
            "type": "RECEIVED",
            "message": "Please call me",
            "time": 1672572600000,
          },
        },
      ],
    );
  }
}
