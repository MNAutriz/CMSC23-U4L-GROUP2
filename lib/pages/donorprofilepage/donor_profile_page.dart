import 'package:cmsc23project/pages/donorprofilepage/donor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DonorProfilePage extends StatelessWidget {
  const DonorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Donor sample = Donor(
        firstname: "Juan",
        lastname: "Loona",
        contactno: "09171231234",
        email: "sample@gmail.com");

    return SafeArea( // so that first widget is rendered under the status bar
      child: Scaffold(
          backgroundColor: const Color(0xFFEEF2E6),
          // appBar: AppBar(
          //   automaticallyImplyLeading: false, 
          //   // title: Text("${sample.firstname} ${sample.lastname}",
          //   //   style: const TextStyle(color: Color(0xFFEEF2E6), fontWeight: FontWeight.bold)),
          //   iconTheme: const IconThemeData(color: Color(0xFFEEF2E6)),
          //   backgroundColor: const Color(0xFF093731),
          // ),
          body: SingleChildScrollView(
            child: Column(children: [
              const ProfilePictureStack(),
              const SizedBox(height: 150),
              ProfileInfoTile(
                  text: "${sample.firstname} ${sample.lastname}",
                  icon: const Icon(Icons.person, color: Color(0xFFEEF2E6))),
              ProfileInfoTile(
                  text: "${sample.email}",
                  icon: const Icon(Icons.alternate_email, color: Color(0xFFEEF2E6))),
              ProfileInfoTile(
                  text: "${sample.contactno}",
                  icon: const Icon(Icons.phone, color: Color(0xFFEEF2E6))),
            ]),
          )),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({super.key, required this.text, required this.icon});

  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 16),
      child: ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        leading: icon,
        title: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFFEEF2E6))),
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
      clipBehavior: Clip.none, // so that circle avatar can still be seen outside container
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF093731),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: ClipRRect( // to make sure image always take up entire container
              borderRadius: BorderRadius.circular(20),
              child: Image.network( // nice green picture of leaves
                'https://media.istockphoto.com/id/1402801804/photo/closeup-nature-view-of-palms-and-monstera-and-fern-leaf-background.webp?b=1&s=170667a&w=0&k=20&c=oj5HjeYMh3RmxbjUNDiMfn6VSngH_-1uPIUPD7BhNus=',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
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
          child: CircleAvatar(
            radius: 75,
            backgroundColor: Color(0xFF3D8361),
            child: Icon(
              Icons.person,
              size: 55,
              color: Color(0xFFEEF2E6),
            ),
          ),
        )
      ],
    );
  }
}

