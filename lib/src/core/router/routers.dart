import 'package:akur_app/src/core/utils/app_routes.dart' as Approute;
import 'package:akur_app/src/shared/presentation/pages.dart';

import 'package:flutter/material.dart';

class AppRouter {
  // static AppPreferences _appPreferences = AppPreferences();

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (_) => SplashScreenPage(),
      Approute.WRAPPER: (_) => Wrapper(),
      // Approute.LOGIN_ROUTE: (_) => LoginPage(),
      // Approute.SIGNUP_ROUTE: (_) => SignupPage(),
      Approute.ONBOARDING_ROUTE: (_) => OnboardingScreen(),
      Approute.DASHBOARD: (context) => DashboardScreen(),
      Approute.CHART_ROUTE: (context) => ChartScreen(),
      Approute.PRODUK_TABLE: (context) => ProdukDataTableScreen(),
    };
  }
}
