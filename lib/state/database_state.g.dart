// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DatabaseNotifier)
final databaseProvider = DatabaseNotifierProvider._();

final class DatabaseNotifierProvider
    extends $NotifierProvider<DatabaseNotifier, DatabaseStateData> {
  DatabaseNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'databaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$databaseNotifierHash();

  @$internal
  @override
  DatabaseNotifier create() => DatabaseNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DatabaseStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DatabaseStateData>(value),
    );
  }
}

String _$databaseNotifierHash() => r'30fb28415f4387e2edc66b49d76dd7470a1f364f';

abstract class _$DatabaseNotifier extends $Notifier<DatabaseStateData> {
  DatabaseStateData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DatabaseStateData, DatabaseStateData>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DatabaseStateData, DatabaseStateData>,
        DatabaseStateData,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
