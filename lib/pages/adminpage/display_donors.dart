import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/models/donor_model.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayDonors extends StatefulWidget {
  const DisplayDonors({super.key});

  @override
  State<DisplayDonors> createState() => _DisplayDonorsState();
}

class _DisplayDonorsState extends State<DisplayDonors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF2E6),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "View Donors Here",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Color(0xFF1C6758)),
              ),
            ),
            Expanded(child: stream()),
          ]),
    );
  }

  //stream builder widget
  Widget stream() {
    // access the database of donors in the provider
    Stream<QuerySnapshot> donorsStream = context.watch<DonorProvider>().donor;

    return StreamBuilder(
      stream: donorsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error encountered! ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
          //no data yet
        } else if (!snapshot.hasData) {
          return emptyDonors();
          //empty donors database
        } else if (snapshot.data!.docs.isEmpty) {
          //empty donors database
          return emptyDonors();
        }

        //if the donors database is not empty
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: ((context, index) {
            Donor donor = Donor.fromJson(
                snapshot.data?.docs[index].data() as Map<String, dynamic>);

            //get the id of a document
            donor.id = snapshot.data?.docs[index].id;
            //card containing list tile of donors database
            return Card(
              //list tile of each donor
              child: ListTile(
                onTap: () {},
                leading: const Icon(Icons.person),
                title: Text(donor.email),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  //edit button
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: const Color(0xFF3D8361)),
                      onPressed: () {},
                      icon: const Icon(Icons.create)),
                  //delete button
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: const Color(0xFF3D8361)),
                      onPressed: () {},
                      icon: const Icon(Icons.delete)),
                  //view button
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: const Color(0xFF3D8361)),
                      onPressed: () {},
                      icon: const Icon(Icons.mail))
                ]),
              ),
            );
          }),
        );
      },
    );
  }

  //Widget for empty donors database
  Widget emptyDonors() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.people),
          Text("No registered donors yet"),
        ],
      ),
    );
  }
}
