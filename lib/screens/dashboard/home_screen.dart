import 'package:blood_donor_app/controllers/data_controller.dart';
import 'package:blood_donor_app/controllers/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";
  TextEditingController searchController = TextEditingController();
  ProfileController profileController = Get.put(ProfileController());
  DataController dataController = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 44,
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('donors')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Column(
                                children: snapshot.data?.docs.map((e) {
                                      return Column(
                                        children: [
                                          e["donorId"] ==
                                                  FirebaseAuth
                                                      .instance.currentUser?.uid
                                              ? Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              e['image']),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          'Hello,',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF0C253F),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          e['username'],
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF5A5A5A),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox()
                                        ],
                                      );
                                    }).toList() ??
                                    []);
                          }
                        }),

                    // IconButton(
                    //   onPressed: () {
                    //     Get.to(()=>const UserNotificationScreen());
                    //   },
                    //   icon: const Icon(
                    //     Icons.notification_add,
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ],
                ),
                Divider(),
        //         Text(
        //   'All Posts',
        //   style: TextStyle(
        //     color: Color(0xFF1A1A1A),
        //     fontSize: 20,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('time', descending: true)
                    .snapshots(),
                //
                //

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: EdgeInsets.only(top: Get.height * .4),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: Get.height * .34),
                      child: const Center(
                        child: Text(
                          'No post available yet.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.redAccent),
                        ),
                      ),
                    );
                  } else {
                    //

                    return Column(
                      children: [
                        const SizedBox(
                          height: 6,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length ?? 0,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.docs[index];

                            return Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Card(
                                  shadowColor: Colors.black,
                                  color: Colors.white,
                                  elevation: 13,
                                  child: Container(
                                    // height: 166,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      data['image']),
                                                ),
                                                const SizedBox(
                                                  width: 9,
                                                ),
                                                Text(
                                                  data['username'],
                                                  style: const TextStyle(
                                                    color: Color(0xFF474747),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Contact',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  data['contact'],
                                                  style: const TextStyle(
                                                    color: Color(0xFF474747),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Address',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  data['address'],
                                                  style: const TextStyle(
                                                    color: Color(0xFF474747),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                                child: Text(
                                              data['post'],
                                            ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            DocumentSnapshot<
                                                    Map<String, dynamic>>
                                                document =
                                                await FirebaseFirestore.instance
                                                    .collection('donors')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .get();
                                            final userData = document.data()!;
                                            String userName =
                                                userData['username'];

                                            dataController.createNotification(
                                              userId: data['userId'],
                                              message:
                                                  '$userName accepted your request now you can chat with each other',
                                            );
                                            LocalNotificationService
                                                .sendNotification(
                                                    title: 'Request Accepted',
                                                    message:
                                                        '$userName accepted your request',
                                                    token: data['fcmToken']);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: Get.width * .44),
                                            height: 34,
                                            width: Get.width * .4,
                                            decoration: BoxDecoration(
                                              color: Colors.red.shade400,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Accept',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
