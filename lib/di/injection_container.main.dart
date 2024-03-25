part of 'injection_container.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  _injectThemeProvider(sharedPrefs);
}

void _injectThemeProvider(SharedPreferences sharedPrefs) {
  locator.registerLazySingleton(() => sharedPrefs);
  locator.registerSingleton<ThemeCubit>(ThemeCubit(locator()));
}
