import 'package:rentndeal/constants/consts.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({super.key, required this.location, required this.press});
  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press, horizontalTitleGap: 0,
          leading: const Icon(Icons.location_pin, color: black),
          title: Text(location, maxLines: 2, overflow: TextOverflow.ellipsis).paddingOnly(left: CSizes.defaultSpace),
        ),
        const Divider(height: 0.5, thickness: 0.5,color: black),
      ],
    );
  }





}