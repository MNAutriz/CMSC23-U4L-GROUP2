import 'package:cmsc23project/models/donor_model.dart';
import 'package:flutter/material.dart';

class ViewDonorDetails extends StatefulWidget {
  //donor instance for containing details
  final Donor donor;
  const ViewDonorDetails({super.key, required this.donor});

  @override
  State<ViewDonorDetails> createState() => _ViewDonorDetailsState();
}

class _ViewDonorDetailsState extends State<ViewDonorDetails> {
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
          Icons.person,
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
                          "Name                 ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Expanded(
                            child: Text(
                          widget.donor.name,
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
                          "Username         ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Expanded(
                            child: Text(
                          widget.donor.username,
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
                          "Contact No.      ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Expanded(
                            child: Text(
                          widget.donor.contact,
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
                          "Email                 ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Expanded(
                            child: Text(
                          widget.donor.email,
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
                          "Address            ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Expanded(
                            child: Text(
                          "${widget.donor.address.first}",
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
            widget.donor.name,
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
