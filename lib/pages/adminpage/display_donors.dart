import 'package:cloud_firestore/cloud_firestore.dart';
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
    // access the list of slambook entries in the provider
    Stream<QuerySnapshot> users = context.watch<SlambookProvider>().slambook;

    return StreamBuilder(
      stream: slambookStream,
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
          return emptyFriend();
          //empty friends list
        } else if (snapshot.data!.docs.isEmpty) {
          //empty friends list
          return emptyFriend();
        }

        //if the friends list is not empty
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: ((context, index) {
            Slambook slambook = Slambook.fromJson(
                snapshot.data?.docs[index].data() as Map<String, dynamic>);

            //get the id of a document
            slambook.id = snapshot.data?.docs[index].id;
            //card containing list tile of friends list
            return Card(
              //list tile of each friend
              child: ListTile(
                onTap: () {
                  //view details
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewDetails(slambook: slambook)));
                },
                leading: const Icon(Icons.person),
                title: Text(slambook.name),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  //edit button
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: Colors.purple),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              EditForm(slambook: slambook),
                        );
                      },
                      icon: const Icon(Icons.create)),
                  //delete button
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: Colors.purple),
                      onPressed: () {
                        // ignore: avoid_print
                        print("Deleted ${slambook.name}");
                        context
                            .read<SlambookProvider>()
                            .deleteFriend(slambook.id!);
                      },
                      icon: const Icon(Icons.delete)),
                  //view button
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: Colors.purple),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewDetails(slambook: slambook)));
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

  //Widget for empty friend list
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
