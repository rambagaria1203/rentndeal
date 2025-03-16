import 'constants/consts.dart';

Future<void>  main() async {

  // Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Local Storage
  await GetStorage.init();

  // Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase & Authenticate Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository())
  );
  
  runApp(const App());
}