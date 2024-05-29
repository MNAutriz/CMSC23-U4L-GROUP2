import 'package:cmsc23project/models/organization_model.dart';
import 'package:flutter/material.dart';

class ViewOrganizationDetails extends StatefulWidget {
  //organization instance for containing details
  final Organization organization;

  const ViewOrganizationDetails({super.key, required this.organization});

  @override
  State<ViewOrganizationDetails> createState() =>
      _ViewOrganizationDetailsState();
}

class _ViewOrganizationDetailsState extends State<ViewOrganizationDetails> {
  //details widget
  Widget details() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),

        const Icon(
          Icons.people,
          size: 60,
        ),
        const SizedBox(
          height: 15,
        ),

        //printing summary row containing columns
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //name
                        const Text(
                          "Organization Name      ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Expanded(
                            child: Text(
                          widget.organization.organizationName,
                          style: const TextStyle(fontSize: 20),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //nickname
                        const Text(
                          "Contact Person            ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Expanded(
                            child: Text(
                          widget.organization.name,
                          style: const TextStyle(fontSize: 20),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //age
                        const Text(
                          "Username                     ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Expanded(
                            child: Text(
                          widget.organization.username,
                          style: const TextStyle(fontSize: 20),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //relationship status
                        const Text(
                          "Email                             ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Expanded(
                            child: Text(
                          widget.organization.email,
                          style: const TextStyle(fontSize: 20),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //happiness level
                        const Text(
                          "Contact No.                  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Expanded(
                            child: Text(
                          widget.organization.contact,
                          style: const TextStyle(fontSize: 20),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //happiness level
                        const Text(
                          "Address                        ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Expanded(
                            child: Text(
                          widget.organization.address,
                          style: const TextStyle(fontSize: 20),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ])),
          ],
        ),
        //go back button
        TextButton(
            onPressed: () {
              //pop viewdetails
              Navigator.pop(context);
            },
            child: const Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF1C6758)),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEEF2E6),
        appBar: AppBar(
          title: Text(
            widget.organization.organizationName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF1C6758),
          foregroundColor: const Color(0xFFEEF2E6),
        ),

        //details of friend
        body: details());
  }
}
