import 'package:chatting_app/Futures/authentication/data/data_sources/local/auth_local_data_sources.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Futures/authentication/data/data_sources/remote/auth_remote_data_srources.dart';
import 'Futures/authentication/domain/repositories/authentication_repository.dart';
import 'Futures/authentication/presentation/bloc/authentication_bloc.dart';
import 'Futures/authentication/domain/usecase/checkAuthStatus_usecase.dart';
import 'Futures/authentication/domain/usecase/login_usecase.dart';
import 'Futures/authentication/domain/usecase/logout_usecase.dart';
import 'Futures/authentication/domain/usecase/signup_usecase.dart';
import 'Futures/authentication/data/repositories/authentication_repository_impl.dart';
import 'core/network/network_info.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  //! Futures - Authentication
  // Bloc
  sl.registerFactory(() => AuthenticationBloc(sl(), sl(), sl(), sl()));
  // Usecases
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => SignupUsecase(sl()));
  // Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl() , sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSources>(
    () => AuthLocalDataSourcesImpl(sl()),
  );
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  sl.registerLazySingleton<http.Client>(() => http.Client());
}
