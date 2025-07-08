import 'package:modular_flutter/modular_flutter.dart';

import 'post_router.dart';
import 'repositories/post_repository.dart';
import 'repositories/post_repository_impl.dart';
import 'services/post_service.dart';

class PostModule extends Module<PostRouter> {
  @override
  PostRouter createRouter() => PostRouter();

  @override
  String get moduleName => 'post';

  @override
  void registerDependencies(ServiceLocator locator, AppConfig appConfig) {
    // Register the post service as a singleton
    locator.registerLazySingleton<PostService>(() => PostService());

    // Register the post repository as a singleton
    locator.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(locator.get<PostService>()),
    );
  }
}
