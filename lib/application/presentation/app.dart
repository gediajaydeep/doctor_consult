import 'package:consultations_app_test/application/data/appointments/dataSources/appointments_local_data_source.dart';
import 'package:consultations_app_test/application/data/appointments/repositories/appointments_repository_impl.dart';
import 'package:consultations_app_test/application/data/chats/dataSources/chats_local_data_source.dart';
import 'package:consultations_app_test/application/data/chats/repositories/chats_repository_impl.dart';
import 'package:consultations_app_test/application/data/doctors/dataSources/doctors_local_data_source.dart';
import 'package:consultations_app_test/application/data/doctors/repositories/doctors_repository_impl.dart';
import 'package:consultations_app_test/application/data/user/dataSources/user_local_data_source.dart';
import 'package:consultations_app_test/application/data/user/repositories/user_repository_impl.dart';
import 'package:consultations_app_test/application/domain/appointments/repositories/appointments_repository.dart';
import 'package:consultations_app_test/application/domain/chats/repositories/chats_repository.dart';
import 'package:consultations_app_test/application/domain/chats/useCases/get_chat_list.dart';
import 'package:consultations_app_test/application/domain/doctors/repositories/doctors_repository.dart';
import 'package:consultations_app_test/application/domain/user/repositories/user_repository.dart';
import 'package:consultations_app_test/application/domain/user/useCases/get_user_details.dart';
import 'package:consultations_app_test/application/presentation/chat/list/viewModel/chat_list_view_model.dart';
import 'package:consultations_app_test/core/dataManager/cached_data_manager.dart';
import 'package:consultations_app_test/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/appointments/useCases/get_appointment_list.dart';
import '../domain/doctors/useCases/get_top_doctors_list.dart';
import 'home/viewModels/home_view_model.dart';
import 'main/view/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.getAppTheme(context),
      home: MultiProvider(
        providers: [
          Provider<CachedDataManager>(
            create: (context) => CachedDataManager(),
          ),
          Provider<UserLocalDataSource>(
            create: (context) => UserLocalDataSourceImpl(
              cachedDataManager: context.read<CachedDataManager>(),
            ),
          ),
          Provider<UserRepository>(
            create: (context) => UserRepositoryImpl(
              context.read<UserLocalDataSource>(),
            ),
          ),
          Provider<GetUserDetails>(
            create: (context) => GetUserDetails(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          Provider<DoctorsLocalDataSource>(
            create: (context) => DoctorsLocalDataSourceImpl(
              cahcedDataManager: context.read<CachedDataManager>(),
            ),
          ),
          Provider<DoctorsRepository>(
            create: (context) => DoctorsRepositoryImpl(
              localDataSource: context.read<DoctorsLocalDataSource>(),
            ),
          ),
          Provider<AppointmentsLocalDataSource>(
            create: (context) => AppointmentsLocalDataSourceImpl(
              cachedDataManager: context.read<CachedDataManager>(),
            ),
          ),
          Provider<AppointmentsRepository>(
            create: (context) => AppointmentsRepositoryImpl(
              localDataSource: context.read<AppointmentsLocalDataSource>(),
            ),
          ),
          Provider<GetTopDoctorsList>(
            create: (context) => GetTopDoctorsList(
              context.read<DoctorsRepository>(),
            ),
          ),
          Provider<GetAppointmentList>(
            create: (context) => GetAppointmentList(
              appointmentsRepository: context.read<AppointmentsRepository>(),
            ),
          ),
          ChangeNotifierProvider<HomeViewModel>(
            create: (context) => HomeViewModel(
              getUserDetails: context.read<GetUserDetails>(),
              getAppointmentList: context.read<GetAppointmentList>(),
              getTopDoctorsList: context.read<GetTopDoctorsList>(),
            ),
          ),
          Provider<ChatsLocalDataSource>(
            create: (context) => ChatsLocalDataSourceImpl(
              context.read<CachedDataManager>(),
            ),
          ),
          Provider<ChatsRepository>(
            create: (context) => ChatsRepositoryImpl(
              localDataSource: context.read<ChatsLocalDataSource>(),
            ),
          ),
          Provider<GetChatList>(
            create: (context) => GetChatList(
              chatsRepository: context.read<ChatsRepository>(),
            ),
          ),
          ChangeNotifierProvider<ChatListViewModel>(
            create: (context) => ChatListViewModel(
              getChatList: context.read<GetChatList>(),
            ),
          ),
        ],
        child: const MainScreen(),
      ),
    );
  }
}
