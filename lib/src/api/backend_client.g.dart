// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(backendClient)
final backendClientProvider = BackendClientProvider._();

final class BackendClientProvider
    extends $FunctionalProvider<BackendClient, BackendClient, BackendClient>
    with $Provider<BackendClient> {
  BackendClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backendClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backendClientHash();

  @$internal
  @override
  $ProviderElement<BackendClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BackendClient create(Ref ref) {
    return backendClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackendClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackendClient>(value),
    );
  }
}

String _$backendClientHash() => r'c4ea0d8ff7a7a4a74f2ee12677aec7e9943f2bff';
