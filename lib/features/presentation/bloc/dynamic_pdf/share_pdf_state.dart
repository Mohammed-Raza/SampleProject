part of 'share_pdf_cubit.dart';

@immutable
sealed class SharePdfState {}

final class SharePdfInitial extends SharePdfState {}

final class SharePdfMainState extends SharePdfState {}

final class ImageCaptureLoadingState extends SharePdfState {}
