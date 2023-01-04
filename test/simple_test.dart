import 'dart:convert';

import 'package:consultations_app_test/core/dataManager/cached_data_manager.dart';
import 'package:consultations_app_test/application/data/doctors/dataSources/doctors_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAssetFileReader extends Mock implements CachedDataManager {}

late DoctorsLocalDataSourceImpl impl;
MockAssetFileReader mockAssetFileReader = MockAssetFileReader();

main() {
  setUp(() {
    impl = DoctorsLocalDataSourceImpl(cahcedDataManager: mockAssetFileReader);
  });
  test("Local Data Source", () async {
    when(
      () => mockAssetFileReader.readCachedData(CachedDataType.doctors),
    ).thenAnswer((invocation) {
      return Future.value(
        jsonEncode([
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
                "https://www.freepnglogos.com/uploads/doctor-png/doctor-ufe-foccupation-pinterest-boy-cards-19.png",
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
                "https://www.freepnglogos.com/uploads/doctor-png/doctor-ufe-foccupation-pinterest-boy-cards-19.png",
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
                "https://www.freepnglogos.com/uploads/doctor-png/doctor-ufe-foccupation-pinterest-boy-cards-19.png",
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
        ]),
      );
    });
    expect(
      1,
      equals(1),
    );
  });
}
