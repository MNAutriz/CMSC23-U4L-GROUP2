import 'package:flutter/material.dart';

class ViewDonation extends StatefulWidget {
  //donor form instance
  final Map<String, dynamic> form;
  const ViewDonation({super.key, required this.form});

  @override
  State<ViewDonation> createState() => _DonorDonationsState();
}

class _DonorDonationsState extends State<ViewDonation> {
  //status values
  static const Map<int, String> status = {
    0: "Pending",
    1: "Confirmed",
    2: "Scheduled for Pick-up",
    3: "Complete",
    4: "Canceled",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEEF2E6),
        appBar: AppBar(
          title: Text(
            "Donation Details",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF1C6758),
          foregroundColor: const Color(0xFFEEF2E6),
        ),

        //details of friend
        body: details());
  }

  //details widget
  Widget details() {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //donation drive name
              Text("${widget.form['donationDriveName']}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              //organization name
              Text("Organization: ${widget.form['orgName']}",
                  style: const TextStyle(fontSize: 17)),
              const SizedBox(height: 5),
              //donation types
              Text("Donation Types: ${widget.form['donationTypes'].join(', ')}",
                  style: const TextStyle(fontSize: 17)),
              const SizedBox(height: 5),
              //date and time
              Text("Date and Time: ${widget.form['donationDateTime']}",
                  style: const TextStyle(fontSize: 17)),
              const SizedBox(height: 5),
              //weight and unit
              Text(
                  "Weight: ${widget.form['weight']} ${widget.form['weightUnit']}",
                  style: const TextStyle(fontSize: 17)),
              const SizedBox(height: 5),
              //isForPickup
              Text("For Pick-up: ${widget.form['forPickup'] ? 'Yes' : 'No'}",
                  style: const TextStyle(fontSize: 17)),
              const SizedBox(height: 5),
              widget.form['forPickup']
                  ? Text(
                      "Pick-up Address: ${widget.form['pickupAddresses'] ?? 'N/A'}",
                      style: const TextStyle(fontSize: 17))
                  : Container(),
              const SizedBox(height: 5),
              Text("Contact No: ${widget.form['contactNo'] ?? 'N/A'}",
                  style: const TextStyle(fontSize: 17)),
              const SizedBox(height: 5),
              Text("Status: ${status[widget.form['status']]}",
                  style: const TextStyle(fontSize: 17)),
            ],
          ),
        ),
      ),
    );
  }
}
