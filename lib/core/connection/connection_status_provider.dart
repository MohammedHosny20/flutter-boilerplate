import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playx/playx.dart';

/// App-wide connection status — Playx controller + banner side-effects.
final connectionStatusProvider =
    NotifierProvider<ConnectionStatusNotifier, ConnectionStatus>(
      ConnectionStatusNotifier.new,
    );

class ConnectionStatusNotifier extends Notifier<ConnectionStatus> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  ConnectionStatusController? _controller;

  VoidCallback? _onRetryClicked;
  bool _retryOnConnectionRestored = true;
  FocusNode? _focusNode;
  bool _hasUiBinding = false;

  /// UI hooks from [ConnectionStatusWidget] (retry / focus only).
  void bindConnectionStatusUi({
    VoidCallback? onRetryClicked,
    bool retryOnConnectionRestored = true,
    FocusNode? focusNode,
  }) {
    _onRetryClicked = onRetryClicked;
    _retryOnConnectionRestored = retryOnConnectionRestored;
    _focusNode = focusNode;

    if (_hasUiBinding) return;
    _hasUiBinding = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleConnectionStatusChange(state);
    });
  }

  @override
  ConnectionStatus build() {
    final controller = ConnectionStatusController(
      checkType: ConnectionCheckType.both,
    );
    _controller = controller;
    controller.addListener(_onControllerChanged);

    Future.microtask(controller.checkInternetConnection);

    ref.onDispose(() {
      final c = _controller;
      if (c == null) return;
      c.removeListener(_onControllerChanged);
      c.stopListeningToConnectionStatus();
      c.dispose();
      _controller = null;
    });

    return controller.value;
  }

  void _onControllerChanged() {
    final controller = _controller;
    if (controller == null) return;
    final next = controller.value;
    if (state == next) return;
    state = next;
    _handleConnectionStatusChange(next);
  }

  void _handleConnectionStatusChange(ConnectionStatus status) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (status) {
        case ConnectionStatus.connected:
          hideBanner();
        case ConnectionStatus.disconnected:
          _showDisconnectedBanner();
        case ConnectionStatus.connectionRestored:
          _showConnectionRestoredBanner();
          if (_retryOnConnectionRestored) {
            _onRetryClicked?.call();
          }
      }
    });
  }

  ScaffoldMessengerState? get _messenger => scaffoldMessengerKey.currentState;

  void hideBanner() {
    _messenger?.hideCurrentMaterialBanner();
  }

  void _showDisconnectedBanner() {
    final messenger = _messenger;
    if (messenger == null) return;

    final showRetry = _onRetryClicked != null;
    messenger
      ..removeCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: CustomText(
            AppTrans.noInternetConnectionBannerMsg.tr(),
            textStyle: const TextStyle(color: AppColors.baseWhite),
            textAlign: showRetry ? TextAlign.start : TextAlign.center,
          ),
          backgroundColor: const Color(0xFFA42920),
          actions: [
            if (showRetry)
              TextButton(
                onPressed: () => _onRetryClicked?.call(),
                focusNode: _focusNode,
                child: CustomText(
                  AppTrans.refresh.tr(),
                  textStyle: const TextStyle(color: AppColors.baseWhite),
                ),
              )
            else
              TextButton(
                onPressed: hideBanner,
                child: CustomText(
                  AppTrans.noInternetConnectionDismissBannerMsg.tr(),
                  textStyle: const TextStyle(color: AppColors.baseWhite),
                ),
              ),
          ],
        ),
      );
  }

  void _showConnectionRestoredBanner() {
    final messenger = _messenger;
    if (messenger == null) return;

    messenger
      ..removeCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: CustomText(
            AppTrans.internetConnectionRestoredBannerMsg.tr(),
            textStyle: const TextStyle(color: AppColors.baseWhite),
          ),
          backgroundColor: const Color(0xFF297A2C),
          actions: [
            TextButton(
              onPressed: hideBanner,
              focusNode: _focusNode,
              child: CustomText(
                AppTrans.noInternetConnectionDismissBannerMsg.tr(),
                textStyle: const TextStyle(color: AppColors.baseWhite),
              ),
            ),
          ],
        ),
      );
  }
}
