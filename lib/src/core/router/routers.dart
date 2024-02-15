// ignore: library_prefixes
import 'package:akur_app/src/core/utils/app_routes.dart' as Approute;
import 'package:akur_app/src/shared/presentation/pages.dart';

import 'package:flutter/material.dart';

class AppRouter {
  // static AppPreferences _appPreferences = AppPreferences();

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (_) => const SplashScreenPage(),
      Approute.WRAPPER: (_) => const Wrapper(),
      // Approute.LOGIN_ROUTE: (_) => LoginPage(),
      // Approute.SIGNUP_ROUTE: (_) => SignupPage(),
      Approute.ONBOARDING_ROUTE: (_) => const OnboardingScreen(),
      Approute.DASHBOARD: (context) => const DashboardScreen(),
      Approute.CHART_ROUTE: (context) => const ChartScreen(),
      Approute.PRODUK_TABLE: (context) => const ProdukDataTableScreen(),
    };
  }
}
