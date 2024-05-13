import 'package:cmsc23project/pages/donorprofilepage/donor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DonorProfilePage extends StatelessWidget {
  const DonorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final Donor sample = Donor(firstname: "Juan", lastname: "Loona", contactno: "09171231234", email: "sample@gmail.com");

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E6),
        appBar: AppBar(
          backgroundColor: const Color(0xFF093731),
        ),
        body: Column(children: 
        [
          const ProfilePictureStack(),
          const SizedBox(
            height: 100
          ),
          ProfileInfoTile(text: "${sample.firstname} ${sample.lastname}", icon: const Icon(Icons.person, color: Colors.white)),
          ProfileInfoTile(text: "${sample.email}", icon: const Icon(Icons.alternate_email, color: Colors.white)),
          ProfileInfoTile(text: "${sample.contactno}", icon: const Icon(Icons.phone, color: Colors.white))
          ]));
  }
}

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.text,
    required this.icon
});

  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:32.0, right: 32.0, bottom: 16),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        leading: icon,
        title: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
        tileColor: const Color(0xFF093731),
      ),
    );
  }
}

class ProfilePictureStack extends StatelessWidget {
  const ProfilePictureStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
                color:  Color(0xFF093731),
                borderRadius:  BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)))),
        Positioned(
          bottom: -80,
          child: Container(
            width: 160,
            height: 160,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEEF2E6),
            ),
          ),
        ),
        const Positioned(
          bottom: -75,
          child: CircleAvatar(radius: 75, child: Icon(Icons.person, size: 55,)),
        )
      ],
    );
  }
}
