part of '../../ui.dart';

/// Provides [ScaffoldMessenger] for connection banners.
/// All connection / banner logic lives in [ConnectionStatusNotifier].
class ConnectionStatusWidget extends ConsumerWidget {
  final Widget child;
  final bool enableCheckingInternet;
  final bool retryOnConnectionRestored;
  final VoidCallback? onRetryClicked;
  final FocusNode? focusNode;

  const ConnectionStatusWidget({
    required this.child,
    this.enableCheckingInternet = true,
    this.onRetryClicked,
    this.retryOnConnectionRestored = true,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(connectionStatusProvider.notifier);

    if (enableCheckingInternet) {
      ref.watch(connectionStatusProvider);
      notifier.bindConnectionStatusUi(
        onRetryClicked: onRetryClicked,
        retryOnConnectionRestored: retryOnConnectionRestored,
        focusNode: focusNode,
      );
    }

    return ScaffoldMessenger(
      key: notifier.scaffoldMessengerKey,
      child: Scaffold(body: child),
    );
  }
}
