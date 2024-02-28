import 'package:get_it/get_it.dart';
import 'package:gst_calcuator/features/gst_calculator/presentation/cubit/gst_calculator_cubit.dart';
import 'package:gst_calcuator/features/gst_calculator_history/presentation/cubit/calcation_history_cubit.dart';
import 'package:gst_calcuator/features/interest_calculator/presentation/cubit/interest_calculator_cubit.dart';
import 'package:gst_calcuator/features/menu_option/presentation/cubit/menu_option_cubit.dart';
import 'package:gst_calcuator/features/money_cash_counter/presentation/cubit/money_cash_counter_cubit.dart';
import 'package:gst_calcuator/features/tax_slab/presentation/cubit/tax_slab_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  // getItInstance.registerLazySingleton<Dio>(() => Dio());
  // getItInstance.registerLazySingleton<Client>(() => Client());
  // getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  // Analytics Property
  // getItInstance.registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  //Data source Dependency
  // getItInstance.registerLazySingleton<SettingDataSource>(() => SettingDataSourceImpl(client: getItInstance()));

  //Data Repository Dependency

  // getItInstance
  // .registerLazySingleton<SettingRemoteRepository>(() => SettingRepositoryImpl(settingDataSource: getItInstance()));

  //Usecase Dependency
  // getItInstance.registerLazySingleton<GetPolicyData>(() => GetPolicyData(settingRemoteRepository: getItInstance()));

  //Bloc Dependency
  // getItInstance.registerFactory(() => SettingPageBloc(loadingCubit: getItInstance()));

  //Cubit Dependency
  // getItInstance.registerLazySingleton<BottomNavigationCubit>(() => BottomNavigationCubit());
  getItInstance.registerFactory<GstCalculatorCubit>(() => GstCalculatorCubit());
  getItInstance.registerFactory<CalcationHistoryCubit>(() => CalcationHistoryCubit());
  getItInstance.registerFactory<MenuOptionCubit>(() => MenuOptionCubit());
  getItInstance.registerFactory<TaxSlabCubit>(() => TaxSlabCubit());
  getItInstance.registerFactory<MoneyCashCounterCubit>(() => MoneyCashCounterCubit());
  getItInstance.registerFactory<InterestCalculatorCubit>(() => InterestCalculatorCubit());

  //Theme Dependency
  // getItInstance.registerLazySingleton<GetPreferredTheme>(() => GetPreferredTheme(appRepository: getItInstance()));
}
