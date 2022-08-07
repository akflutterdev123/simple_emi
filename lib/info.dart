import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoView extends StatefulWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20.sp,
            ),
          ),
          leadingWidth: 10.w,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "arunkumar__kannan",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 19.sp),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
                size: 20.sp,
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.bell,
                  color: Colors.black,
                ))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(15.sp),
          height: 100.h,
          width: 100.w,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                              radius: 30.sp,
                              backgroundImage:
                                  const AssetImage("assets/dp.jpg")),
                          Column(
                            children: [
                              Text(
                                "785",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Text(
                                "Posts",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "2.1M",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "74",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Text(
                                "Following",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20.sp),
                      Text(
                        " 📱 Android App Developer",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 10.sp),
                      Text(
                        " 🤵 Entreprenur",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 10.sp),
                      Text(
                        " ♾️ Explore Infinitely",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      InkWell(
                        onTap: () {
                          insta("https://www.instagram.com/arunkumar__kannan/");
                        },
                        child: Container(
                          width: 100.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            color: Colors.pink,
                          ),
                          child: Center(
                              child: Text(
                            "Follow",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      // IconButton(
                      //   icon: Icon(
                      //     FontAwesomeIcons.instagram,
                      //     color: Colors.pink,
                      //     size: 25.sp,
                      //   ),
                      //   onPressed: () {
                      //     // insta('https://www.instagram.com/this_is_arunkumar_kannan/');
                      //   },
                      // ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    playstore(
                        "https://play.google.com/store/apps/details?id=com.ideal.simple_emi_app");
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: Colors.grey.shade200),
                    child: Column(
                      children: [
                        Text(
                          'Simple EMI',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: const Color(0xffbd5837),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15.sp),
                        Text(
                          'Accuracy matters',
                          style:
                              TextStyle(color: Colors.brown, fontSize: 15.sp),
                        ),
                        SizedBox(height: 15.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              FontAwesomeIcons.googlePlay,
                              color: Color.fromARGB(255, 0, 41, 2),
                            ),
                            Text('Rate us on the PlayStore',
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 151, 42, 2),
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ));
  }

  void insta(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {}
  }

  void playstore(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print("cant open");
    }
  }
}
