// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_workouts_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PastWorkoutsNotifier)
final pastWorkoutsProvider = PastWorkoutsNotifierProvider._();

final class PastWorkoutsNotifierProvider
    extends $NotifierProvider<PastWorkoutsNotifier, PastWorkoutsStateData> {
  PastWorkoutsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pastWorkoutsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pastWorkoutsNotifierHash();

  @$internal
  @override
  PastWorkoutsNotifier create() => PastWorkoutsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PastWorkoutsStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PastWorkoutsStateData>(value),
    );
  }
}

String _$pastWorkoutsNotifierHash() =>
    r'f19e11464e0cc914569e3b5c64cf346142df6ff6';

abstract class _$PastWorkoutsNotifier extends $Notifier<PastWorkoutsStateData> {
  PastWorkoutsStateData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PastWorkoutsStateData, PastWorkoutsStateData>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PastWorkoutsStateData, PastWorkoutsStateData>,
        PastWorkoutsStateData,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
