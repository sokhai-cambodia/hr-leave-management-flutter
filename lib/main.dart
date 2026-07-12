import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/theme/app_theme.dart';
import 'core/constants/env.dart';
import 'core/errors/api_exception.dart';
import 'core/network/dio_client.dart';
import 'core/storage/local_cache_service.dart';
import 'core/storage/secure_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final secureStorageService = Get.put(SecureStorageService());
  Get.put(LocalCacheService());
  Get.put(DioClient(secureStorageService: secureStorageService));

  runApp(const HrLeaveManagementApp());
}

class HrLeaveManagementApp extends StatelessWidget {
  const HrLeaveManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HR Leave Management',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      home: const PlaceholderHomePage(),
    );
  }
}

class PlaceholderHomePage extends StatelessWidget {
  const PlaceholderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HR Leave Management')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_month_outlined, size: 64),
              const SizedBox(height: 16),
              const Text(
                'Project scaffold ready.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'API base URL: ${Env.apiBaseUrl}',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const _HealthCheckSection(),
            ],
          ),
        ),
      ),
    );
  }
}

enum _HealthState { idle, loading, healthy, unhealthy, error }

/// Throwaway connectivity smoke test — Task 0.2. Superseded once the app
/// shell/dashboard land in Phase 2.
class _HealthCheckSection extends StatefulWidget {
  const _HealthCheckSection();

  @override
  State<_HealthCheckSection> createState() => _HealthCheckSectionState();
}

class _HealthCheckSectionState extends State<_HealthCheckSection> {
  _HealthState _state = _HealthState.idle;
  String? _errorMessage;

  Future<void> _checkHealth() async {
    setState(() {
      _state = _HealthState.loading;
      _errorMessage = null;
    });

    try {
      final dio = Get.find<DioClient>().dio;
      final response = await dio.get<bool>('/utils/health-check/');
      setState(() {
        _state = response.data == true
            ? _HealthState.healthy
            : _HealthState.unhealthy;
      });
    } on DioException catch (e) {
      final apiException = ApiException.fromDioException(e);
      setState(() {
        _state = _HealthState.error;
        _errorMessage = apiException.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _state == _HealthState.loading ? null : _checkHealth,
          child: const Text('Check backend connectivity'),
        ),
        const SizedBox(height: 8),
        Text(
          switch (_state) {
            _HealthState.idle => '',
            _HealthState.loading => 'Checking…',
            _HealthState.healthy => 'Backend reachable: true',
            _HealthState.unhealthy => 'Backend reachable: false',
            _HealthState.error => _errorMessage ?? 'Unknown error',
          },
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
