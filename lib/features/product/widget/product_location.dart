import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductLocationProductDetails extends StatelessWidget {
  final String locationName;
  final double latitude;
  final double longitude;

  const ProductLocationProductDetails({
    super.key,
    required this.locationName,
    required this.latitude,
    required this.longitude,
  });

  /// ✅ Function to Open Google Maps with Coordinates
  Future<void> openGoogleMaps(double latitude, double longitude) async {
    final Uri googleUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      throw Exception("Could not open Google Maps.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Iconsax.location, size: 24, color: Colors.red),
        const SizedBox(width: 8),
        Flexible(
          child: GestureDetector(
            onTap: () => openGoogleMaps(latitude, longitude),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locationName, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyLarge?.copyWith( color: Colors.blue, fontWeight: FontWeight.w600, decoration: TextDecoration.underline,),),
                Text("Tap to view on Google Maps",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 12,),),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => openGoogleMaps(latitude, longitude),
          icon: const Icon(Iconsax.map, color: Colors.blue, size: 28),
          tooltip: "Open in Google Maps",
        ),
      ],
    );
  }
}
