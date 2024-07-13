import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:html';

import '../../themes/text_styles.dart';

class UserBadge extends StatefulWidget {
  final String logoURL;
  final String eventName;
  final DateTime startDate;
  final DateTime endDate;
  final String passportName;
  final String country;
  final String role;
  final String userId;
  final String eventId;

  const UserBadge({
    super.key,
    required this.logoURL,
    required this.eventName,
    required this.startDate,
    required this.endDate,
    required this.passportName,
    required this.country,
    required this.role,
    required this.userId,
    required this.eventId,
  });

  @override
  State<UserBadge> createState() => _UserBadgeState();
}

class _UserBadgeState extends State<UserBadge> {
  late String hostDomain = "";

  @override
  void initState() {
    super.initState();
    _fetchHostDomainName();
  }

  Future<void> _fetchHostDomainName() async {
    String currentURL = window.location.href;
    final uri = Uri.parse(currentURL);
    final baseUrl = '${uri.scheme}://${uri.host}';
    hostDomain = baseUrl;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDateRange =
        '${DateFormat('d').format(widget.startDate)} - ${DateFormat('d').format(widget.endDate)} ${DateFormat('MMMM').format(widget.startDate)} ${widget.startDate.year}';

    return Center(
      child: Container(
        width: 1240,
        height: 1748,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/user_badge_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Title
            Positioned(
              top: 325,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  widget.eventName.toUpperCase(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.lightTextTheme.displayMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Date
            Positioned(
              top: 550,
              left: 0,
              right: 0,
              child: Text(
                formattedDateRange.toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTextStyles.lightTextTheme.displayMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            // QR Code
            Positioned(
              top: 700,
              left: 0,
              right: 0,
              child: Center(
                child: QrImageView(
                  data:
                      "$hostDomain/admin/event-registration/${widget.eventId}/${widget.userId}",
                  version: QrVersions.auto,
                  size: 400,
                  dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.circle,
                      color: Colors.black),
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Name
            Positioned(
              top: 1150,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  widget.passportName.toUpperCase(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.lightTextTheme.displayLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Country
            Positioned(
              top: 1425,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.country.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.darkTextTheme.displayLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Bottom brown section
            Positioned(
              top: 1575,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.role.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.darkTextTheme.displayMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
