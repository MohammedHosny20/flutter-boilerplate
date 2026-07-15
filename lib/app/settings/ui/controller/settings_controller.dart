part of '../imports/settings_imports.dart';

enum SettingsPage { settings, language, theme }

class SettingsState {
  final XLocale? currentLocale;
  final XTheme currentTheme;
  final int currentPage;

  SettingsState({
    this.currentLocale,
    required this.currentTheme,
    this.currentPage = 0,
  });

  SettingsState copyWith({
    XLocale? currentLocale,
    XTheme? currentTheme,
    int? currentPage,
  }) {
    return SettingsState(
      currentLocale: currentLocale ?? this.currentLocale,
      currentTheme: currentTheme ?? this.currentTheme,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class SettingsController extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    return SettingsState(
      currentLocale: PlayxLocalization.currentXLocale,
      currentTheme: PlayxTheme.currentTheme,
      currentPage: SettingsPage.settings.index,
    );
  }

  List<XLocale> get supportedLocales => PlayxLocalization.supportedXLocales;

  void handleLanguageSelection(XLocale locale) {
    state = state.copyWith(currentLocale: locale);
    PlayxLocalization.updateTo(locale);
    final ctx = NavigationUtils.navigationContext;
    if (ctx != null && Navigator.of(ctx).canPop()) Navigator.of(ctx).pop();
  }

  Future<void> handleThemeSelection(
    XTheme theme, {
    BuildContext? context,
  }) async {
    final ctx = NavigationUtils.navigationContext;
    if (ctx != null && Navigator.of(ctx).canPop()) Navigator.of(ctx).pop();
    await Future.delayed(const Duration(milliseconds: 500));
    await PlayxTheme.updateTo(
      theme,
      animation: PlayxThemeClipperAnimation(),
    );
    state = state.copyWith(currentTheme: theme);
  }

  Future<void> handleLogOutTap() async {
    ref.read(appControllerProvider.notifier).logout();
  }

  Future<void> showSettingsModalSheet(
    BuildContext context,
  ) async {
    final pageNotifier = ValueNotifier<int>(state.currentPage);
    final currentState = state;
    return CustomModal.showModal(
      context: context,
      pageListBuilder: (context) => [
        CustomModal.buildCustomModalPage(
          title: AppTrans.settings,
          body: const SettingsView(),
          onClosePressed: closeSettingsModalSheet,
          context: context,
        ),
        BuildSettingsPage.buildModalPage(
          title: AppTrans.language,
          items: supportedLocales,
          onItemSelected: (lang) => handleLanguageSelection(lang),
          itemName: (lang) => lang.name,
          isItemSelected: (lang) => currentState.currentLocale == lang,
          onBackButtonPressed: () {
            state = state.copyWith(
              currentPage: SettingsPage.settings.index,
            );
          },
          showPreviousButton: !false,
          onCloseButtonPressed: closeSettingsModalSheet,
          context: context,
        ),
        BuildSettingsPage.buildModalPage(
          title: AppTrans.theme,
          items: PlayxTheme.supportedThemes,
          onItemSelected: (theme) => handleThemeSelection(theme, context: context),
          itemName: (theme) => theme.name.tr(context: context),
          isItemSelected: (theme) => currentState.currentTheme.id == theme.id,
          onBackButtonPressed: () {
            state = state.copyWith(
              currentPage: SettingsPage.settings.index,
            );
          },
          showPreviousButton: !false,
          onCloseButtonPressed: closeSettingsModalSheet,
          context: context,
        ),
      ],
      onModalDismissedWithBarrierTap: closeSettingsModalSheet,
      pageIndexNotifier: pageNotifier,
    );
  }

  Future<void> showSettingsModalPageSheet(
    BuildContext context,
    SliverWoltModalSheetPage page,
  ) async {
    return CustomModal.showPageModal(
      context: context,
      pageBuilder: (context) => page,
      onModalDismissedWithBarrierTap: closeSettingsModalSheet,
    );
  }

  void closeSettingsModalSheet() {
    final ctx = NavigationUtils.navigationContext;
    if (ctx != null && Navigator.of(ctx).canPop()) {
      Navigator.of(ctx).pop();
    }
    state = state.copyWith(currentPage: SettingsPage.settings.index);
  }
}

final settingsControllerProvider = NotifierProvider<SettingsController, SettingsState>(
  SettingsController.new,
);
