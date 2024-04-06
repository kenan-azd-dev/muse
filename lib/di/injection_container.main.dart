part of 'injection_container.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  final cacheClient = CacheClient();

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  final googleSignIn = GoogleSignIn.standard();

  locator.registerSingleton<CacheClient>(cacheClient);

  _injectAuth(
    cacheClient: locator<CacheClient>(),
    firebaseAuth: firebaseAuth,
    firebaseFirestore: firebaseFirestore,
    googleSignIn: googleSignIn,
  );

  _injectThemeProvider(sharedPrefs);
}

void _injectThemeProvider(SharedPreferences sharedPrefs) {
  locator.registerLazySingleton(() => sharedPrefs);
  locator.registerSingleton<ThemeCubit>(ThemeCubit(locator()));
}

void _injectAuth({
  required CacheClient cacheClient,
  required FirebaseAuth firebaseAuth,
  required FirebaseFirestore firebaseFirestore,
  required GoogleSignIn googleSignIn,
}) {
  locator.registerSingleton<AuthApi>(AuthRemoteDataSource(
    cache: cacheClient,
    auth: firebaseAuth,
    firestore: firebaseFirestore,
    googleSignIn: googleSignIn,
  ));

  locator.registerSingleton<AuthRepository>(
      AuthRepository(authApi: locator<AuthApi>()));

  locator.registerFactory<AppUserBloc>(
      () => AppUserBloc(locator<AuthRepository>()));

  locator
      .registerFactory<LoginCubit>(() => LoginCubit(locator<AuthRepository>()));

  locator.registerFactory<SignUpCubit>(
      () => SignUpCubit(locator<AuthRepository>()));

  locator.registerFactory<CreateProfileCubit>(
      () => CreateProfileCubit(locator<AuthRepository>()));
}
