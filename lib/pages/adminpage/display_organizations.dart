import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/models/organization_model.dart';
import 'package:cmsc23project/pages/adminpage/organization_drives.dart';
import 'package:cmsc23project/pages/adminpage/view_org_details.dart';
import 'package:cmsc23project/providers/organization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayOrganizations extends StatefulWidget {
  const DisplayOrganizations({super.key});

  @override
  State<DisplayOrganizations> createState() => _DisplayOrganizationsState();
}

class _DisplayOrganizationsState extends State<DisplayOrganizations> {
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
                "View Organizations",
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
    // access the database of organizations in the provider
    Stream<QuerySnapshot> orgsStream =
        context.watch<OrganizationProvider>().organization;

    return StreamBuilder(
      stream: orgsStream,
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
          return emptyOrganizations();
          //empty organizations database
        } else if (snapshot.data!.docs.isEmpty) {
          //empty organizations database
          return emptyOrganizations();
        }

        //if the organizations database is not empty
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: ((context, index) {
            Organization organization = Organization.fromJson(
                snapshot.data?.docs[index].data() as Map<String, dynamic>);

            //get the id of a document
            //organization.id = snapshot.data?.docs[index].id;
            //card containing list tile of organizations database
            return Card(
              //list tile of each organization
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OrganizationDrives(organization: organization)));
                },
                leading: const Icon(Icons.people),
                title: Text(organization.organizationName),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  //view button
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
                                builder: (context) => ViewOrganizationDetails(
                                    organization: organization)));
                      },
                      icon: const Icon(Icons.mail))
                ]),
              ),
            );
          }),
        );
      },
    );
  }

  //Widget for empty organizations database
  Widget emptyOrganizations() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.people),
          Text("No registered organizations yet"),
        ],
      ),
    );
  }
}
