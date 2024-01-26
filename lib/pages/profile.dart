import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pocketpedia/core/constants/string.dart';

class ProfileDisplay extends StatefulWidget {
  const ProfileDisplay({super.key});

  @override
  State<ProfileDisplay> createState() => _ProfileDisplayState();
}

class _ProfileDisplayState extends State<ProfileDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey,
            backgroundImage: Image.asset('assets/profile_pic.jpeg').image,
          ),
          const Gap(20),
          const Text(
            Strings.name,
            style: TextStyle(fontSize: 24),
          ),
          const Text(Strings.role, style: TextStyle(fontSize: 20)),
          const Gap(20),
          const Text(Strings.about_title, style: TextStyle(fontSize: 20)),
          const Text(Strings.about_description, style: TextStyle(fontSize: 14)),
          const Gap(20),
          const Text(Strings.about_project_title,
              style: TextStyle(fontSize: 20)),
          const Text(
            Strings.about_project_description,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.justify,
          ),
          const Gap(20),
          const Text(Strings.about_contact_title,
              style: TextStyle(fontSize: 20)),
          Row(
            children: [
              Image.asset(
                'assets/in.png',
                width: 20,
                height: 20,
              ),
              const Text(Strings.about_contact_description1,
                  style: TextStyle(fontSize: 14)),
            ],
          ),
          Row(
            children: [
              Image.asset(
                'assets/git.jpeg',
                width: 20,
                height: 20,
              ),
              const Text(
                Strings.about_contact_description2,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          const Gap(20),
          const Text(Strings.about_copyright_title,
              style: TextStyle(fontSize: 20)),
          const Text(
            Strings.about_copyright_description,
            style: TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
