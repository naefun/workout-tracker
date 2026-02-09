// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_tab_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentTabNotifier)
final currentTabProvider = CurrentTabNotifierProvider._();

final class CurrentTabNotifierProvider
    extends $NotifierProvider<CurrentTabNotifier, CurrentTabStateData> {
  CurrentTabNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'currentTabProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$currentTabNotifierHash();

  @$internal
  @override
  CurrentTabNotifier create() => CurrentTabNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrentTabStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrentTabStateData>(value),
    );
  }
}

String _$currentTabNotifierHash() =>
    r'1f33353319cad953721ca6cbdae9fa931da53131';

abstract class _$CurrentTabNotifier extends $Notifier<CurrentTabStateData> {
  CurrentTabStateData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CurrentTabStateData, CurrentTabStateData>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<CurrentTabStateData, CurrentTabStateData>,
        CurrentTabStateData,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
