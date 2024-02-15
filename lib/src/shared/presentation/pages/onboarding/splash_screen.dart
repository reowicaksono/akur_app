part of '../../pages.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final AppPreferences _preferences = AppPreferences();

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () async {
      final isLogin = await _preferences.getLoginState();
      final bool isOnBoarding = await _preferences.getOnBoardingState();
      if (isOnBoarding) {
        if (isLogin) {
          Navigation.navigateToPageReplacement(Approute.WRAPPER);
        } else {
          Navigation.navigateToPageReplacement(Approute.DASHBOARD);
        }
      } else {
        Navigation.navigateToPageReplacement(Approute.ONBOARDING_ROUTE);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Text("Login"),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Text(
              'Copyright PT.Reo Wicaksono. 2020',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
