import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sample_project/core/extensions/context_extension.dart';

class UploadAttachmentView extends StatefulWidget {
  final Function()? captureImage, uploadImage;
  const UploadAttachmentView({super.key, this.captureImage, this.uploadImage});

  @override
  State<UploadAttachmentView> createState() => _UploadAttachmentViewState();
}

class _UploadAttachmentViewState extends State<UploadAttachmentView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.2,
      margin: EdgeInsets.fromLTRB(10, 0, 10, context.height * 0.02),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Gap(context.height * 0.008),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: context.width * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.upload_file),
                  Gap(context.width * 0.03),
                  Text(context.l10n.uploadImage,
                      style:
                          _style.apply(fontWeightDelta: 10, fontSizeDelta: 3)),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.clear)),
                ),
              ),
            ],
          ),
          Gap(context.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildIconWithText(
                  text: context.l10n.photos,
                  icon: Icons.image_outlined,
                  color: Colors.lightBlue,
                  onTap: widget.uploadImage),
              Gap(context.width * 0.1),
              BuildIconWithText(
                  text: context.l10n.camera,
                  color: Colors.amber,
                  icon: Icons.camera_alt_outlined,
                  onTap: widget.captureImage),
            ],
          )
        ],
      ),
    );
  }

  TextStyle get _style =>
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
}

class BuildIconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;
  final Color color;
  const BuildIconWithText(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.text,
      this.color = Colors.indigo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 45, color: color),
          Gap(context.height * 0.005),
          Text(text)
        ],
      ),
    );
  }
}
