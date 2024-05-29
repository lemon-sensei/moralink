// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import '../../../themes/colors.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';


class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                event.thumbnail,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    event.description,
                    style: textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: isDarkMode
                          ? AppColors.darkIconColor
                          : AppColors.lightIconColor),
                      const SizedBox(width: 4.0),
                      Text(
                        '${event.startDate.day}/${event.startDate.month}/${event.startDate.year} - ${event.endDate.day}/${event.endDate.month}/${event.endDate.year}',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: isDarkMode
                          ? AppColors.darkIconColor
                          : AppColors.lightIconColor),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          '${event.locationName}, ${event.locationAddress}',
                          style: textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
