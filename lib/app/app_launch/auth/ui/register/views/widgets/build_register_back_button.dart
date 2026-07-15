part of '../../imports/register_imports.dart';

class BuildRegisterBackButton extends ConsumerWidget {
  const BuildRegisterBackButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerControllerProvider);
    return AnimatedOpacity(
      opacity: state.currentLoginMethod == LoginMethod.email ? 1 : 0,
      duration: const Duration(milliseconds: 500),

      /// Back button
      child: Container(
        width: double.infinity,
        alignment: AlignmentDirectional.centerStart,
        padding: EdgeInsets.symmetric(
          vertical: 4.r,
          horizontal: 4.r,
        ),
        child: IconButton(
          onPressed: () {
            ref.read(registerControllerProvider.notifier).setCurrentLoginMethod(null);
          },
          icon: Icon(
            Icons.adaptive.arrow_back,
            color: context.colors.onSurface,
          ),
        ),
      ),
    );
  }
}
