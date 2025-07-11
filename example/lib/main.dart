import 'package:flutter/material.dart';
import 'package:modular_flutter/modular_flutter.dart';
import 'package:viewmodel/viewmodel.dart';

import 'modules/post/post_module.dart';

class DefaultAppConfig extends AppConfig {
  @override
  String get apiBaseUrl {
    return getConfigValue<String>('API_BASE_URL') ?? "https://api.khode.com";
  }

  @override
  String get appName {
    return getConfigValue<String>('APP_NAME') ?? "Khode App";
  }

  @override
  bool get isDebugMode => true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register dependencies that required before app start
  await Modular.register((locator) async {
    final appConfig = DefaultAppConfig();
    await appConfig.loadEnvFilePath('.env');
    locator.registerLazySingleton<AppConfig>(() => appConfig);
  });

  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ModularApp(
        modules: [AppModule(), PostModule()],
        child: Builder(
          builder: (context) {
            return MaterialApp.router(routerConfig: Modular.routerConfig);
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(serviceLocator.get<AppConfig>().appName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Modular Architecture Test',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Total Modules: 2501',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                context.push('/posts');
              },
              icon: const Icon(Icons.post_add),
              label: const Text('Posts Module'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class AppModule extends Module {
  @override
  ModuleRouter createRouter() => SimpleRouter();

  @override
  String get moduleName => 'app';

  @override
  void registerDependencies(ServiceLocator locator, AppConfig appConfig) {
    locator.registerLazySingleton<SimpleService>(() => SimpleService());
  }
}

class SimpleRouter extends ModuleRouter {
  @override
  String get basePath => '/';

  @override
  List<RouteBase> get routes => [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
  ];
}

class SimpleService {
  String get message => 'Hello, World!';
}
