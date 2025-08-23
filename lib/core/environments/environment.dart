import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../mixins/helper_mixin.dart';
import 'app_configuration.dart';

enum EnvironmentType { farmersMarket, healthyFood }

class Environment {
  static final Environment _singleton = Environment._internal();

  AppConfiguration? _configuration;

  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  void configure() {
    ///Fetching selected flavor Flavor
    EnvironmentType environmentType =
        const String.fromEnvironment('FLUTTER_APP_FLAVOR').isNotEmpty
            ? (HelperMixin.enumFromString(EnvironmentType.values,
                    const String.fromEnvironment('FLUTTER_APP_FLAVOR')) ??
                EnvironmentType.farmersMarket)
            : EnvironmentType.farmersMarket;

    _configuration = switch (environmentType) {
      EnvironmentType.farmersMarket => farmersMarketConfig,
      EnvironmentType.healthyFood => healthyFoodConfig
    };
  }

  AppConfiguration get configuration {
    assert(_configuration != null, 'configure the Environment');
    return _configuration!;
  }

  AppConfiguration get farmersMarketConfig {
    return AppConfiguration(
        logoPath: Assets.logosFarmersMarket,
        orgName: 'Farmers Market',
        seedColor: Colors.teal,
        hoverColor: Colors.teal.shade50,
        shadowColor: Colors.tealAccent,
        appBarColor: Colors.teal.shade200);
  }

  AppConfiguration get healthyFoodConfig {
    return AppConfiguration(
        logoPath: Assets.logosHealthyFood,
        orgName: 'Healthy Food',
        seedColor: const Color.fromRGBO(2, 56, 232, 1),
        hoverColor: const Color.fromRGBO(202, 221, 250, 1),
        shadowColor: Colors.indigoAccent,
        appBarColor: const Color.fromRGBO(37, 116, 245, 1));
  }
}
