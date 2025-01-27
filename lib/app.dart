import 'package:rentndeal/bindings/general_bindings.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      // Show Loader or circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen.
      home: const Scaffold(backgroundColor: CColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white),),)
    );
  }

}