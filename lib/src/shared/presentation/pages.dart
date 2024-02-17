import 'dart:async';
import 'dart:math';

import 'package:akur_app/src/core/common/app_styles.dart';
import 'package:akur_app/src/core/common/navigator.dart';
import 'package:akur_app/src/core/utils/app_preferences.dart';
import 'package:akur_app/src/shared/bloc/produk/produk_bloc.dart';
import 'package:akur_app/src/shared/model/produk_model.dart';
import 'package:akur_app/src/shared/model/row_produk_model.dart';

import 'package:akur_app/src/shared/presentation/pages/dashboard/search/search_screen.dart';
import 'package:akur_app/src/shared/presentation/pages/dashboard/settings/settings_screen.dart';
import 'package:akur_app/src/shared/presentation/widgets/indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
// ignore: library_prefixes
import 'package:akur_app/src/core/utils/app_routes.dart' as Approute;
import 'package:uuid/uuid.dart';

part 'pages/onboarding/onboarding_screen.dart';
part 'pages/dashboard/dashboard_screen.dart';
part 'pages/onboarding/splash_screen.dart';
part 'pages/wrapper.dart';
part 'widgets/dashboard_widgets.dart';
part 'widgets/data_source_table_widgets.dart';
part 'widgets/alert_dialog_add_widgets.dart';
part 'pages/dashboard/home/home_screen.dart';
part 'pages/dashboard/home/chart_screen.dart';
part 'pages/dashboard/home/produk_table_screen.dart';
