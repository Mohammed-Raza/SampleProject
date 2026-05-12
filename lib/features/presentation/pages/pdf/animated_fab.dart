import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/features/presentation/bloc/dynamic_pdf/share_pdf_cubit.dart';
import 'package:sample_project/features/presentation/widgets/image_upload.dart';

import 'create_table.dart';

class AnimatedFloatingActionButtons extends StatefulWidget {
  const AnimatedFloatingActionButtons({super.key});

  @override
  State<AnimatedFloatingActionButtons> createState() =>
      _AnimatedFloatingActionButtonsState();
}

class _AnimatedFloatingActionButtonsState
    extends State<AnimatedFloatingActionButtons>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation,
      rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0)
    ]).animate(animationController);

    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0)
    ]).animate(animationController);

    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0)
    ]).animate(animationController);

    rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SharePdfCubit>();
    return Positioned(
        bottom: 50,
        right: 20,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            IgnorePointer(
              child: Container(
                  color: Colors.transparent, height: 150.0, width: 150.0),
            ),
            Transform.translate(
              offset: Offset.fromDirection(getRadiansFromDegree(270),
                  degOneTranslationAnimation.value * 100),
              child: Transform(
                transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value)) *
                    Matrix4.diagonal3Values(
                      degOneTranslationAnimation.value,
                      degOneTranslationAnimation.value,
                      1.0,
                    ),
                alignment: Alignment.center,
                child: CircularActionButton(
                    height: 52,
                    width: 52,
                    icon: Icons.backup_table,
                    color: Colors.cyan,
                    toolTip: context.l10n.createTable,
                    onClick: () => showDialog(
                        context: context,
                        builder: (context) => const CreateTableDialog())),
              ),
            ),
            Transform.translate(
              offset: Offset.fromDirection(getRadiansFromDegree(225),
                  degTwoTranslationAnimation.value * 100),
              child: Transform(
                transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value)) *
                    Matrix4.diagonal3Values(
                      degTwoTranslationAnimation.value,
                      degTwoTranslationAnimation.value,
                      1.0,
                    ),
                alignment: Alignment.center,
                child: CircularActionButton(
                    height: 52,
                    width: 52,
                    icon: Icons.share,
                    color: Colors.amberAccent,
                    toolTip: context.l10n.sharePdfAction,
                    onClick: () => cubit.onClickOfSharePdf(context)),
              ),
            ),
            Transform.translate(
              offset: Offset.fromDirection(getRadiansFromDegree(180),
                  degThreeTranslationAnimation.value * 100),
              child: Transform(
                transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value)) *
                    Matrix4.diagonal3Values(
                      degThreeTranslationAnimation.value,
                      degThreeTranslationAnimation.value,
                      1.0,
                    ),
                alignment: Alignment.center,
                child: CircularActionButton(
                    height: 52,
                    width: 52,
                    icon: Icons.add,
                    color: Colors.pinkAccent,
                    toolTip: context.l10n.addImages,
                    onClick: () => showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            UploadAttachmentView(captureImage: () {
                              context.pop();
                              cubit.onClickOfCamera();
                            }, uploadImage: () {
                              context.pop();
                              cubit.onClickOfCamera(isCamera: false);
                            }))),
              ),
            ),
            Transform(
              transform: Matrix4.rotationZ(
                  getRadiansFromDegree(rotationAnimation.value)),
              alignment: Alignment.center,
              child: CircularActionButton(
                  height: 60,
                  width: 60,
                  icon: Icons.menu,
                  color: Colors.deepOrangeAccent,
                  onClick: () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                    } else {
                      animationController.forward();
                    }
                  }),
            ),
          ],
        ));
  }
}

class CircularActionButton extends StatelessWidget {
  final double width, height;
  final Color color;
  final IconData icon;
  final Function() onClick;
  final String toolTip;
  const CircularActionButton(
      {super.key,
      required this.height,
      required this.width,
      required this.icon,
      required this.color,
      required this.onClick,
      this.toolTip = ''});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: IconButton(
            onPressed: onClick,
            tooltip: toolTip,
            enableFeedback: true,
            icon: Icon(icon, color: Colors.white)),
      ),
    );
  }
}
