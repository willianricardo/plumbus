import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plumbus/core/theme/app_colors.dart';

class AppTextStyles {
  static final title = GoogleFonts.lexendDeca(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppColors.light,
  );
  static final titleBold = GoogleFonts.lexendDeca(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.light,
  );
  static final subtitle = GoogleFonts.lexendDeca(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    color: AppColors.light,
  );
  static final subtitleBold = GoogleFonts.lexendDeca(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.light,
  );
  static final titleBody = GoogleFonts.lexendDeca(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.darkTint,
  );
  static final subtitleBody = GoogleFonts.lexendDeca(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: AppColors.medium,
  );
  static final captionBody = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumShade,
  );
  static final captionEmail = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.medium,
  );
  static final captionTimestamp = GoogleFonts.inter(
    color: AppColors.medium,
    fontSize: 12,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic,
  );
}
