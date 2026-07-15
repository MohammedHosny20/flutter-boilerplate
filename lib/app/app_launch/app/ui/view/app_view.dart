part of '../imports/app_imports.dart';

class AppView extends ConsumerWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appControllerProvider);
    return Container();
  }
}
