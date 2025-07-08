library;

// re-export flutter_riverpod
export 'package:flutter_riverpod/flutter_riverpod.dart'
    show
        Override,
        ProviderObserver,
        ProviderScope,
        ProviderContainer,
        ProviderListenable,
        UncontrolledProviderScope,
        ConsumerWidget,
        ConsumerState,
        ConsumerStatefulWidget,
        Consumer,
        Ref,
        WidgetRef,
        Provider,
        StateNotifier,
        StateNotifierProvider,
        AutoDisposeStateNotifierProvider,
        ChangeNotifierProvider,
        AutoDisposeChangeNotifierProvider;
// re-export freezed_annotation for convenience
export 'package:freezed_annotation/freezed_annotation.dart';

export 'src/viewmodel.dart';
export 'src/viewmodel_observer.dart';
export 'src/viewmodel_state.dart';
export 'src/viewmodel_status.dart';
