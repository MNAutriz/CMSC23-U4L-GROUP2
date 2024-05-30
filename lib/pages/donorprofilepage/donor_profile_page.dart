import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorProfilePage extends StatefulWidget {
  const DonorProfilePage({super.key});

  @override
  _DonorProfilePageState createState() => _DonorProfilePageState();
}

class _DonorProfilePageState extends State<DonorProfilePage> {
  bool isEditing = false;
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController contactController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    contactController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    contactController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void saveProfile(String donorId) {
    var donorProvider = context.read<DonorProvider>();
    donorProvider.updateDonor(
      donorId,
      {
        'name': nameController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'contact': contactController.text,
        'address': addressController.text,
      },
    ).then((_) {
      setState(() {
        isEditing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserAuthProvider>().user;
    Stream<QuerySnapshot> donorStream = context.read<DonorProvider>().donor;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEF2E6),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ProfilePictureStack(),
              const SizedBox(height: 100),
              StreamBuilder<QuerySnapshot>(
                stream: donorStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text('No data available');
                  }

                  var donorData = snapshot.data!.docs
                      .firstWhere((doc) => doc['email'] == user!.email);
                  var donorId = donorData.id;

                  if (!isEditing) {
                    nameController.text = donorData['name'];
                    usernameController.text = donorData['username'];
                    emailController.text = donorData['email'];
                    contactController.text = donorData['contact'];
                    addressController.text = donorData['address'];
                  }

                  return Column(
                    children: [
                      ProfileInfoTile(
                        text: isEditing
                            ? TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(),
                                ),
                              )
                            : donorData['name'],
                        icon: const Icon(Icons.person, color: Color(0xFFEEF2E6)),
                      ),
                      ProfileInfoTile(
                        text: isEditing
                            ? TextField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                  border: OutlineInputBorder(),
                                ),
                              )
                            : donorData['username'],
                        icon: const Icon(Icons.alternate_email, color: Color(0xFFEEF2E6)),
                      ),
                      ProfileInfoTile(
                        text: isEditing
                            ? TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                ),
                              )
                            : donorData['email'],
                        icon: const Icon(Icons.email_rounded, color: Color(0xFFEEF2E6)),
                      ),
                      ProfileInfoTile(
                        text: isEditing
                            ? TextField(
                                controller: contactController,
                                decoration: const InputDecoration(
                                  labelText: 'Contact',
                                  border: OutlineInputBorder(),
                                ),
                              )
                            : donorData['contact'],
                        icon: const Icon(Icons.phone, color: Color(0xFFEEF2E6)),
                      ),
                      ProfileInfoTile(
                        text: isEditing
                            ? TextField(
                                controller: addressController,
                                decoration: const InputDecoration(
                                  labelText: 'Address',
                                  border: OutlineInputBorder(),
                                ),
                              )
                            : donorData['address'],
                        icon: const Icon(Icons.house, color: Color(0xFFEEF2E6)),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (isEditing) {
                            saveProfile(donorId);
                          } else {
                            setState(() {
                              isEditing = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFFEEF2E6), backgroundColor: const Color(0xFF093731),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          isEditing ? 'Save Profile' : 'Edit Profile',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({super.key, required this.text, required this.icon});

  final dynamic text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 10),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        leading: icon,
        title: text is String
            ? Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFFEEF2E6),
                ),
              )
            : text,
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF093731),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
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
        ),
      ],
    );
  }
}
