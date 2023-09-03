import 'package:flutter/foundation.dart';
import 'package:math_mate/core/data/app_repository_impl.dart';
import 'package:math_mate/core/data/sources/db/sqlite_helper.dart';
import 'package:math_mate/core/data/sources/db/db_helper.dart';
import 'package:math_mate/core/data/sources/shared_pref/shared_pref.dart';
import 'package:math_mate/core/domain/app_repository.dart';
import 'package:math_mate/core/domain/usecases/calculate_operation.dart';
import 'package:math_mate/core/domain/usecases/delete_history.dart';
import 'package:math_mate/core/domain/usecases/get_decimal_config.dart';
import 'package:math_mate/core/domain/usecases/get_history_config.dart';
import 'package:math_mate/core/domain/usecases/get_history_list.dart';
import 'package:math_mate/core/domain/usecases/insert_history.dart';
import 'package:math_mate/core/domain/usecases/set_decimal_config.dart';
import 'package:math_mate/core/domain/usecases/set_history_config.dart';
import 'package:math_mate/presentation/bloc/calculator/calculator_bloc.dart';
import 'package:math_mate/presentation/bloc/calculator_settings/calculator_settings_bloc.dart';
import 'package:math_mate/presentation/bloc/history/history_bloc.dart';
import 'package:math_mate/presentation/bloc/settings/settings_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerFactory(() => CalculatorBloc(locator()));
  locator.registerFactory(() => HistoryBloc(locator(), locator(), locator()));
  locator.registerFactory(() => SettingsBloc());
  locator.registerFactory(
      () => CalculatorSettingsBloc(locator(), locator(), locator(), locator()));

  locator.registerLazySingleton(() => InsertHistory(locator()));
  locator.registerLazySingleton(() => GetHistoryList(locator()));
  locator.registerLazySingleton(() => DeleteHistory(locator()));
  locator.registerLazySingleton(() => CalculateOperation(locator()));
  locator.registerLazySingleton(() => SetHistoryConfig(locator()));
  locator.registerLazySingleton(() => GetHistoryConfig(locator()));
  locator.registerLazySingleton(() => SetDecimalConfig(locator()));
  locator.registerLazySingleton(() => GetDecimalConfig(locator()));

  locator.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<SharedPref>(() => SharedPref());
  if (kIsWeb) {
    locator.registerLazySingleton<DbHelper>(() => DbHelperWithHive());
  } else {
    locator.registerLazySingleton<DbHelper>(
      () => DbHelperWithSqlite(
        locator(),
      ),
    );
  }
  locator.registerLazySingleton<SqliteHelper>(() => SqliteHelper());
}
