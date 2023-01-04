import 'package:flutter/material.dart';

enum HomeScreenFeatures { hospital, consultant, recipe, appointment }

class HomeScreenFeaturesView extends StatelessWidget {
  final Function(HomeScreenFeatures) onSelected;

  const HomeScreenFeaturesView({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _featureOption(context, Icons.local_hospital, Colors.red, 'Hospital',
              HomeScreenFeatures.hospital),
          _featureOption(context, Icons.monitor_heart_sharp, Colors.blue,
              'Consultants', HomeScreenFeatures.consultant),
          _featureOption(context, Icons.soup_kitchen, Colors.yellow, 'Recipe',
              HomeScreenFeatures.hospital),
          _featureOption(context, Icons.meeting_room, Colors.green,
              'Appointment', HomeScreenFeatures.appointment)
        ],
      ),
    );
  }

  _featureOption(BuildContext context, IconData icon, Color iconColor,
      String text, HomeScreenFeatures type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }
}
