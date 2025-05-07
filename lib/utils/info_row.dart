import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final bool isClickable;
  final bool isMultiline;
  final VoidCallback? onTap;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.isClickable = false,
    this.isMultiline = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: InkWell(
        onTap: isClickable ? onTap : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 20.sp, color: isClickable ? Colors.blue : Colors.black),
              SizedBox(width: 8.w),
            ],
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: value.isNotEmpty ? value : 'Not available',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: isClickable ? Colors.blue : Colors.black,
                        fontWeight: FontWeight.normal,
                        decoration:
                            isClickable ? TextDecoration.underline : null,
                      ),
                    ),
                  ],
                ),
                maxLines: isMultiline ? null : 1,
                overflow:
                    isMultiline ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
