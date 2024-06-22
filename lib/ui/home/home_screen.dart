import 'dart:developer';

import 'package:chat/constants/components.dart';
import 'package:chat/constants/transitions.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/ui/add_room/add_room.dart';
import 'package:chat/ui/add_room/room_widget.dart';
import 'package:chat/ui/home/home_navigator.dart';
import 'package:chat/ui/home/home_view_model.dart';
import 'package:chat/ui/home/review_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../chat/chat_screen.dart';
import '../../chat/chat_service.dart';
import '../../constants/colors.dart';
import '../../model/my_user.dart';
import '../../model/room.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// class HomeScreen2 extends StatefulWidget {
//   static const String routeName = 'home2';
//
//   const HomeScreen2({super.key});
//
//   @override
//   State<HomeScreen2> createState() => _HomeScreen2State();
// }
//
// class _HomeScreen2State extends State<HomeScreen2> implements HomeNavigator {
//   HomeViewModel viewModel = HomeViewModel();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     viewModel.navigator = this;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => viewModel,
//       child: Stack(
//         children: [
//           Container(
//             color: Colors.white,
//           ),
//           Image.asset('assets/images/main_background.png',
//               fit: BoxFit.fill, width: double.infinity),
//           Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: AppBar(
//               elevation: 0,
//               title: const Text(
//                 'Home',
//               ),
//               centerTitle: true,
//             ),
//             floatingActionButton: FloatingActionButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(AddRoom.routeName);
//               },
//               child: const Icon(Icons.add),
//             ),
//             body:
//
//             StreamBuilder<QuerySnapshot<Room>>(
//               stream: DatabaseUtils.getRooms(),
//               builder: (context, asyncSnapShot) {
//                 if (asyncSnapShot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.blue,
//                     ),
//                   );
//                 } else if (asyncSnapShot.hasError) {
//                   return Text(asyncSnapShot.error.toString());
//                 } else {
//                   var roomsList = asyncSnapShot.data?.docs
//                           .map((doc) => doc.data())
//                           .toList() ??
//                       [];
//                   return GridView.builder(
//                     itemBuilder: (context, index) {
//                       return RoomWidgit(
//                         room: roomsList[index],
//                       );
//                     },
//                     itemCount: roomsList.length,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisSpacing: 8,
//                             crossAxisSpacing: 8),
//                   );
//                 }
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//
// }




class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // To track the currently selected tab
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HP App'),
      ),
      body: _buildBody(
          _selectedIndex), // Create a method to build the selected screen
      // bottomNavigationBar: BottomNavigationBar(
      // items: const <BottomNavigationBarItem>[
      // BottomNavigationBarItem(
      // icon: Icon(Icons.home),
      // label: 'Home',
      // ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.contact_mail),
      //   label: 'Contact',
      // ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.person),
      //   label: 'Profile',
      // ),
      // ],
      // currentIndex: _selectedIndex,
      // onTap: _onItemTapped, // Callback when a tab is tapped
      // ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return HomeScreenContent(); // Create a HomeScreenContent widget
      case 1:
        return Container();
      // const ContactScreen(); // Create a ContactScreen widget
      case 2:
        return Container();
      // const ProfileScreen(); // Create a ProfileScreen widget
      default:
        return Container(); // You can replace this with an error screen or handle the case as needed
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomeScreenContent extends StatefulWidget {
  HomeScreenContent({Key? key}) : super(key: key);

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  // final List<Doctor> doctors = [
  //   Doctor(
  //     name: 'Dr. Mahmood Hanafy',
  //     rate: 4.5,
  //     address: '123 Main St, City',
  //     imageUrl: 'assets/images/doctor1.jpg',
  //     specialization: 'Audiologist',
  //   ),
  //   Doctor(
  //     name: 'Dr. Hadeer Ahmed',
  //     rate: 4.8,
  //     address: '456 Elm St, Town',
  //     imageUrl: 'assets/images/doctor2.jpg',
  //     specialization: 'Allergist',
  //   ),
  //   Doctor(
  //     name: 'Dr. Mohamed Mandor',
  //     rate: 4.3,
  //     address: '789 Oak St, Village',
  //     imageUrl: 'assets/images/doctor3.jpg',
  //     specialization: 'Andrologist',
  //   ),
  //   Doctor(
  //     name: 'Dr. Mohamed Said',
  //     rate: 4.7,
  //     address: '101 Pine St, Town',
  //     imageUrl: 'assets/images/doctor4.jpg',
  //     specialization: 'Anesthesiologist',
  //   ),
  //
  //   Doctor(
  //     name: 'Dr. Eman Tantawy',
  //     rate: 4.6,
  //     address: '234 Cedar St, City',
  //     imageUrl: 'assets/images/doctor5.jpg',
  //     specialization: 'Cardiologist',
  //   ),
  //   Doctor(
  //     name: 'Dr. Mohamed Hussein',
  //     rate: 4.9,
  //     address: '567 Maple St, Village',
  //     imageUrl: 'assets/images/doctor6.jpg',
  //     specialization: 'Neurologist',
  //   ),
  //
  //   Doctor(
  //     name: 'Dr. Ahmed Lotfy',
  //     rate: 4.4,
  //     address: '890 Birch St, City',
  //     imageUrl: 'assets/images/doctor7.jpg',
  //     specialization: 'Dentist',
  //   ),
  //   Doctor(
  //     name: 'Dr. Ahmed Fawzy',
  //     rate: 4.2,
  //     address: '432 Oak St, Town',
  //     imageUrl: 'assets/images/doctor8.jpg',
  //     specialization: 'Dermatologist',
  //   ),
  //   // Add more doctor data as needed
  // ];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String,Map<String,dynamic>> doctorsMap={
    'Hanafy':{
      'name': 'Dr. Mahmood Hanafy',
      'rate': 4.5,
      'address': '123 Main St, City',
      'imageUrl': 'assets/images/hanafy.jpg',
      'specialization': 'Audiologist',},
    'Ahmed':{
      'name': 'Dr. Hadeer Ahmed',
      'rate': 4.8,
      'address': '456 Elm St, Town',
      'imageUrl': 'assets/images/hadeer.jpg',
      'specialization': 'Allergist',
    },
    'Mandor':{
      'name': 'Dr. Mohamed Mandor',
      'rate': 4.3,
      'address': '789 Oak St, Village',
      'imageUrl': 'assets/images/mondor.jpg',
      'specialization': 'Andrologist',
    },
    'Said':{
      'name': 'Dr. Mohamed Said',
      'rate': 4.7,
      'address': '101 Pine St, Town',
      'imageUrl': 'assets/images/mohamed said.jpg',
      'specialization': 'Anesthesiologist',
    },
    'Tantawy':{
      'name': 'Dr. Eman Tantawy',
      'rate': 4.6,
      'address': '234 Cedar St, City',
      'imageUrl': 'assets/images/eman.jpg',
      'specialization': 'Cardiologist',
    },
    'Hussein':{
      'name': 'Dr. Mohamed Hussein',
      'rate': 4.9,
      'address': '567 Maple St, Village',
      'imageUrl': 'assets/images/hussien.jpg',
      'specialization': 'Neurologist',
    },
    'Lotfy':{
      'name': 'Dr. Ahmed Lotfy',
      'rate': 4.4,
      'address': '890 Birch St, City',
      'imageUrl': 'assets/images/lotfy.jpg',
      'specialization': 'Dentist',
    },
    'Fawzy':{
      'name': 'Dr. Ahmed Fawzy',
      'rate': 4.2,
      'address': '432 Oak St, Town',
      'imageUrl': 'assets/images/ahmed fawzy.jpg',
      'specialization': 'Dermatologist',
    },



  };


  // List<Doctor> _convertMapToList() {
  //   return doctorsMap.values.map((data) => Doctor.fromMap(data)).toList();
  // }

  // Stream<List<Doctor>> _getDoctors() {
  //   final doctorsList = _convertMapToList();
  //   return Stream.value(doctorsList);
  // }

  Stream<List<MyUser>> _getDoctors() {
    return _firestore.collection('users')
        .where('userType', isEqualTo: 'Doctor')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MyUser.fromDocument(doc))
        .toList());
  }
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder<List<MyUser>>(
        stream: _getDoctors(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final doctors = snapshot.data!;
          // for (var entry in doctors) {
          //  log("name:"+entry.lastName.toString());
          //  // log("entry"+entry.toString());
          // }
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              log("doctor.lastName"+doctor.lastName);
                String docName = doctorsMap[doctor.lastName]!['name']!;
                log("docName");
                log(docName.toString());
                double docRate = doctorsMap[doctor.lastName]!['rate']!;
                String docAddress = doctorsMap[doctor.lastName]!['address']!;
                String docImage = doctorsMap[doctor.lastName]!['imageUrl']!;
                String docspecialization = doctorsMap[doctor.lastName]!['specialization']!;
                return DoctorCard(address: docAddress,
                  imageUrl: docImage,
                  name: docName,
                  rate: docRate,
                  specialization: docspecialization,
                docId:doctor.id,
                );

            },
          );
        },
      );


    //   ListView.builder(
    //   itemCount: doctors.length,
    //   itemBuilder: (context, index) {
    //     final doctor = doctors[index];
    //     return DoctorCard(doctor: doctor);
    //   },
    // );
  }
}



class DoctorCard extends StatefulWidget {
  // final Doctor doctor;
  final String name;
  final double rate;
  final String address;
  final String imageUrl;
  final String specialization;
  final String docId;

  const DoctorCard({super.key,required this.name,required this.rate,required this.address,required this.imageUrl,required this.specialization, required this.docId});

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  final ChatService _chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async{
            String chatId = await _chatService.getOrCreateChat(widget.docId);
            log("here"+widget.name);
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => ChatScreen(chatId: chatId, recipientId: widget.docId,),
            ),
            );
          },
          child: ListTile(
            leading: ClipOval(
                child: Image(
              height: 60,
              width: 60,
              fit: BoxFit.fill,
              image: AssetImage(
                widget.imageUrl,
              ),
            )),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Text(
                    widget.name,
                    style: mainTextStyle(context),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CustomPageRoute(
                          child: const ReviewScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Rate',
                          style: mainTextStyle(context, color: defaultColor),
                        ),
                        const Icon(
                          Icons.star_border_purple500_outlined,
                          color: Colors.deepOrangeAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rate: ${widget.rate.toStringAsFixed(1)}',
                  style: midTextStyle(context, grey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Address: ${widget.address}',
                    style: midTextStyle(context, grey),
                  ),
                ),
                Text(
                  'Specialization: ${widget.specialization}',
                  style: midTextStyle(context, grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with the content of your Contact screen
    return const Center(
      child: Text('Contact Screen Content'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with the content of your Profile screen
    return const Center(
      child: Text('Profile Screen Content'),
    );
  }
}
