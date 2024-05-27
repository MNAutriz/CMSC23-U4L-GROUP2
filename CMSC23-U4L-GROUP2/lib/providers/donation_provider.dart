import 'package:cmsc23project/pages/homepage/donation_model.dart';
import 'package:flutter/material.dart';
import '../pages/homepage/donation_model.dart';

class DonationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  final List<Donation> _donations = [
    Donation(
      title: 'Help Build a School in Africa',
      description: "Support our initiative to construct a school in rural Africa, offering children access to education and a pathway out of poverty. By contributing, you're providing them with a safe and nurturing environment to learn, grow, and thrive. Let's come together to build a brighter future for these deserving children. Join us in making a difference through education.",
      imageUrl: 'https://edgedavao.net/wp-content/uploads/2017/03/Poor-residents-photo.jpg',
      amountRaised: 2500,
      goal: 10000,
      driveDetails: 'Part of the Education Drive 2024',
      status: 'Pending',
    ),
    Donation(
      title: 'Save the Rainforest',
      description: 'Join our campaign to safeguard endangered species and preserve the vital rainforest ecosystem. The rainforests are home to an incredible diversity of life, hosting millions of plant and animal species, many of which are found nowhere else on Earth. However, rampant deforestation, habitat destruction, and poaching pose significant threats to this precious ecosystem and the species that call it home.',
      imageUrl: 'https://philippines.licas.news/wp-content/uploads/2020/08/20200701-Licas-Aeta-Hungey-2-scaled-e1597557910736.jpg',
      amountRaised: 15000,
      goal: 50000,
      driveDetails: 'Part of the Environmental Conservation Drive 2024',
      status: 'Pending',
    ),
    Donation(
      title: 'Provide Meals for the Homeless',
      description: 'We invite you to join us in a meaningful endeavor to support the homeless and vulnerable members of our community by contributing to our initiative to provide food and essential support services. Every day, countless individuals struggle to meet their basic needs, facing hunger, homelessness, and despair. Together, we can make a difference in their lives and offer a glimmer of hope in their darkest moments.',
      imageUrl: 'https://adra.ph/wp-content/uploads/2017/09/Gift-Boxes-Aeta-7-1024x683.jpg',
      amountRaised: 7500,
      goal: 10000,
      driveDetails: 'Part of the Community Support Drive 2024',
      status: 'Pending',
    ),
  ];

  int get selectedIndex => _selectedIndex;
  List<Donation> get donations => _donations;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void updateDonationStatus(Donation donation, String status) {
    donation.status = status;
    notifyListeners();
  }
}
