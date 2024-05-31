# El Gives - Mobile Donation Application

## Group Details
We are a group of three students—Mark Neil Autriz, Kervin Samson, and Michael Uriel—who collaborated to create El Gives, a mobile donation application using Flutter and Dart. Each of us has a specific role:
- **Mark Neil Autriz**: Responsible for the organization's view in the app. His work ensures that organizations can efficiently manage donations, create and monitor donation drives, and communicate effectively with donors.
- **Kervin Samson**: Oversees the donor's view. His focus is on creating an intuitive and user-friendly interface for donors to browse organizations, make donations, and track the status of their contributions.
- **Michael Uriel**: In charge of authentication and the admin's view. He has implemented secure authentication mechanisms for users and created robust functionalities for admin oversight.

Together, we have utilized Flutter and Dart to build El Gives, a comprehensive mobile application designed to streamline the donation process. Our collective goal is to make donating easier and more transparent, fostering a stronger connection between donors and organizations. We are committed to providing a tool that supports charitable activities and enhances the impact of donations within the community.

## Program Description
**El Gives - Mobile Donation Application**

El Gives is a mobile application designed to bridge the gap between donors and charitable organizations, making the process of donating items and managing donations simple, transparent, and efficient. Built with Flutter, this app provides a user-friendly interface for donors to contribute to various organizations and for organizations to manage and track these donations effectively. The application also includes administrative capabilities to ensure proper oversight and approval of organizations participating in the platform.

## Screens Description

### 1. Admin’s View
- **Sign In**: Authentication screen for admin users to access the platform securely.
- **Manage Organizations**: View a comprehensive list of all registered organizations, approve new sign-up requests, and ensure that only legitimate organizations are part of El Gives.
- **Manage Donations**: Oversee all donations made through the platform, ensuring transparency and proper tracking.
- **Manage Donors**: Access a list of all registered donors, maintaining up-to-date information and activity records.

### 2. Donor’s View
- **Homepage**: Displays a list of organizations that donors can support by sending their donations.
- **Donate Screen**:
  - Allows donors to select an organization and provide details about their donation, such as the category (Food, Clothes, Cash, Necessities, Others), pickup or drop-off preferences, item weight, and optional photos.
  - Facilitates scheduling the date and time for donation pickup or drop-off.
  - Enables donors to save multiple addresses for convenience and provide necessary contact information.
  - Generates a QR code for drop-off donations to update their status and allows donors to cancel their donations if needed.
- **Profile**: Provides a personal management screen for donors to update their information and manage saved addresses.

### 3. Organization’s View
- **Homepage**: Lists all donations received by the organization, providing an overview for easy management.
- **Donation Management**:
  - Allows organizations to check the details of each donation and update its status through various stages (Pending, Confirmed, Scheduled for Pick-up, Complete, Canceled).
- **Donation Drives Management**:
  - Enables organizations to create, read, update, and delete donation drives, link donations to these drives, and include photos as proof of where donations have ended up.
  - Sends automatic SMS and notifications to donors about the status and impact of their donations.
- **Profile**: Allows organizations to manage their profile information, including the organization name, details about their mission, and the current status of donation acceptance (open or closed).

## Installation Guide
El Gives is a mobile application designed to connect donors with charitable organizations, streamlining the process of making and managing donations. Follow these steps to install El Gives on your mobile device:

1. **Download the Application**:
   - Visit the official GitHub repository which contains the necessary files that will be efficacious for accessing the resources in the program.
2. **Enable Installation from Unknown Sources (Android Only)**:
   - Open your device's Settings.
   - Navigate to Security (or Apps & notifications).
   - Enable "Install from Unknown Sources" (this option may vary depending on your device model).
3. **Install the Application**:
   - Locate the downloaded installation file on your device.
   - For Android users, this will be an APK file.
   - Tap on the file to begin the installation process.
   - Follow the on-screen instructions to complete the installation.
4. **Set Up the Application**:
   - Open the El Gives app once installation is complete.
   - Create an account or sign in if you already have one.
   - Choose your user role (donor, organization, or admin) and complete the required setup steps.
5. **Explore Features**:
   - **Donors**: Browse organizations to donate to, schedule donations, and manage your profile.
   - **Organizations**: Manage received donations, create and track donation drives, and update your organization profile.
   - **Admin**: Oversee and manage the platform, approve organizations, and monitor donations.

By following these steps, you can easily install and start using El Gives on your mobile device. El Gives provides a comprehensive and user-friendly platform for facilitating donations, ensuring that donors and organizations can connect and collaborate efficiently.

## How to use the app
Welcome to El Gives! This user manual is designed to help you navigate the application effortlessly, whether you're a donor, an organization, or an admin. El Gives aims to make the process of donating and managing donations simple, transparent, and efficient. Below, you will find detailed instructions on how to use each feature of the app to make the most out of your El Gives experience.

### User Roles and Functionalities

#### Donor
1. **Homepage**:
   - Browse a list of organizations available for donations.
   - View brief descriptions and details of each organization.
2. **Donate**:
   - **Select Organization**: Tap on the organization you wish to donate to.
   - **Enter Donation Details**:
     - **Category**: Choose from Food, Clothes, Cash, Necessities, Others.
     - **Pickup or Drop-off**: Specify if items will be picked up or dropped off.
     - **Item Weight**: Enter the weight of items in kg/lbs.
     - **Photo (Optional)**: Upload photos of items.
     - **Schedule**: Set date and time for pickup/drop-off.
     - **Address & Contact**: Enter the pickup address and contact number.
   - **QR Code Generation**: For drop-off, generate a QR code for the organization to scan.
   - **Cancel Donation**: Cancel any donation if necessary.
3. **Profile**:
   - Manage personal information including name, username, password, addresses, and contact number.

#### Organization
1. **Homepage**:
   - View a list of donations received with detailed information.
2. **Manage Donations**:
   - **View Donation Details**: Check the information provided by donors.
   - **Update Status**: Change the status of donations (Pending, Confirmed, Scheduled for Pick-up, Complete, Canceled).
3. **Donation Drives**:
   - **Create New Drive**: Add details about new donation drives including name, description, and photos.
   - **Link Donations**: Associate donations with specific drives.
   - **CRUD Operations**: Create, Read, Update, Delete donation drives.
   - **Send Notifications**: Automatically notify donors about the status and impact of their donations via SMS and app notifications.
4. **Profile**:
   - Manage organization details such as name, about, and donation status (open/closed).

#### Admin
1. **Sign In**:
   - Securely sign in to the admin account.
2. **Manage Organizations**:
   - **View All Organizations**: See a list of all registered organizations.
   - **Approve Requests**: Approve new organization sign-ups.
3. **Manage Donations**:
   - **View All Donations**: Monitor all donations made through the platform.
4. **Manage Donors**:
   - **View All Donors**: Access a comprehensive list of all registered donors.

### Additional Features

1. **QR Code Usage**:
   - For drop-off donations, generate a QR code that organizations can scan to update donation status.
   - Save QR codes on the device with the status and date created.
2. **Google Sign-In**:
   - Option to sign in using Google for a more streamlined authentication process.
