import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/models/organization_model.dart';
import 'package:cmsc23project/pages/adminpage/download_proof.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:cmsc23project/providers/organization_provider.dart';
import 'package:cmsc23project/providers/pending_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationApproval extends StatefulWidget {
  const OrganizationApproval({super.key});

  @override
  State<OrganizationApproval> createState() => _OrganizationApprovalState();
}

class _OrganizationApprovalState extends State<OrganizationApproval> {
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
                "View Pending Applications Here",
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
    // access the database of pending applications for organization in the provider
    Stream<QuerySnapshot> pendingStream =
        context.watch<PendingProvider>().pending;

    return StreamBuilder(
      stream: pendingStream,
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
          return emptyPending();
          //empty database of pending applications for organization
        } else if (snapshot.data!.docs.isEmpty) {
          //empty database of pending applications for organization
          return emptyPending();
        }

        //if the database of pending applications for organization is not empty
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: ((context, index) {
            Organization pending = Organization.fromJson(
                snapshot.data?.docs[index].data() as Map<String, dynamic>);

            //get the id of a document
            //pending.id = snapshot.data?.docs[index].id;
            //card containing list tile of the database of pending applications for organization
            return Card(
              //list tile of each pending application
              child: ListTile(
                onTap: () {},
                leading: const Icon(Icons.person),
                title: Text(pending.organizationName),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  //download button for proof of legitimacy
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: const Color(0xFF3D8361)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DownloadProof(email: pending.email)));
                      },
                      icon: const Icon(Icons.download)),
                  //approve button
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: const Color(0xFF3D8361)),
                      onPressed: () {
                        //add to organization database
                        context
                            .read<OrganizationProvider>()
                            .addOrganization(pending);

                        //delete pending application
                        context
                            .read<PendingProvider>()
                            .deletePending(pending.id!);

                        //remove from donor
                        context.read<DonorProvider>().deleteDonor(pending.id!);
                      },
                      icon: const Icon(Icons.check)),
                  //disapprove button
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: const Color(0xFF3D8361)),
                      onPressed: () {
                        //delete pending application
                        context
                            .read<PendingProvider>()
                            .deletePending(pending.id!);
                      },
                      icon: const Icon(Icons.close)),
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

  //Widget for empty pending applications
  Widget emptyPending() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.people),
          Text("No pending applications"),
        ],
      ),
    );
  }
}
