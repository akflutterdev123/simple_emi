import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_emi/info.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController loanAmount = TextEditingController();
  TextEditingController interestRate = TextEditingController();
  TextEditingController tenure = TextEditingController();
  FocusNode loanmountNode = FocusNode();
  FocusNode intrestNode = FocusNode();
  FocusNode tenurenode = FocusNode();
  bool isyear = false;

  double emi = 0.0;
  String amount = '0';

  String results = '';
  bool gotEMI = false;
  double overAll = 0;
  String total = '';
  double irr = 0;
  double totalinterest = 0;
  double monthlyInterestPercentage = 0;
  double yearlyInterestPerc = 0;
  String myInterest = '';
  final formKey = GlobalKey<FormState>();

  bool _bannerAdloaded = false;

  late BannerAd bannerAd;

  void getBannerAdFunction() async {
    final BannerAd bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-8748639666406914/3565477705',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          _bannerAdloaded = false;
        });
        print("Ad loaded successfully");
      }, onAdFailedToLoad: (ad, e) {
        ad.dispose();
        print("Ad loading error===>" + e.toString());
      }),
    );
    bannerAd.load();
  }

  @override
  void initState() {
    getBannerAdFunction();
    super.initState();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: _bannerAdloaded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(ad: bannerAd),
            )
          : Container(
              height: 05.h,
            ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                loanmountNode.requestFocus();
                setState(() {
                  loanAmount.clear();
                  tenure.clear();
                  interestRate.clear();
                  gotEMI = false;
                });
              },
              icon: const Icon(Icons.refresh)),
          // IconButton(
          //     onPressed: () {

          //     },
          //     icon: const Icon(Icons.info)),
        ],
        title: Text(
          "Simple EMI",
          style: GoogleFonts.mochiyPopOne(
              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InfoView(),
              ));
        },
        child: Center(
          child: Text(
            "I am",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
        ),
      ),
      // InkWell(
      //   child: Container(
      //     height: 2.h,
      //     width: 25.w,
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10.sp), color: Colors.amber),
      //     child: Center(
      //       child: Text(
      //         "Who am I",
      //         style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //             color: Colors.white,
      //             fontSize: 15.sp),
      //       ),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 100.w,
          child: Column(children: [
            inputBox(),
            Padding(
              padding: EdgeInsets.all(15.sp),
              child: outputBox(),
            )
          ]),
        ),
      ),
    );
  }

  void getEMI() {
    if (formKey.currentState!.validate()) {
      tenurenode.unfocus();
      var s = loanAmount.text;
      s = s.split(',').join('');
      int p = int.parse(s);
      double n =
          isyear ? (double.parse(tenure.text) * 12) : double.parse(tenure.text);
      double r = int.parse(interestRate.text) / (1200);
      gotEMI = true;

      setState(() {
        gotEMI = true;
        emi = (p * r * pow((1 + r), n)) / (pow((1 + r), n) - 1);
        results = emi.toStringAsFixed(2);
        overAll = emi * n;
        total = overAll.toStringAsFixed(2);
        totalinterest = overAll - p;
        myInterest = totalinterest.toStringAsFixed(2);
        irr = double.parse(interestRate.text) / 1.8;
      });
    }
  }

  inputBox() {
    return Container(
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15.sp),
      //     color: const Color(0xffbd5837)),
      padding: EdgeInsets.all(15.sp),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFieldWidget(
                child: SizedBox(height: 10.sp),
                width: 65.w,
                title: 'Loan Amount',
                autofocus: true,
                hint: "Enter Loan Amount",
                controller: loanAmount,
                focusNode: loanmountNode,
                onFieldSubmitted: (val) {
                  intrestNode.requestFocus();
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "loan amount required";
                  }
                  return null;
                },
                suffix: Icon(
                  FontAwesomeIcons.indianRupeeSign,
                  size: 17.sp,
                  color: Colors.grey,
                )),
            SizedBox(height: 15.sp),
            CustomTextFieldWidget(
                child: SizedBox(height: 10.sp),
                width: 65.w,
                title: 'Interest Rate',
                autofocus: false,
                hint: "Enter Interest Rate per annum",
                controller: interestRate,
                focusNode: intrestNode,
                onFieldSubmitted: (val) {
                  tenurenode.requestFocus();
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "interest rate required";
                  }
                  return null;
                },
                suffix: Icon(
                  FontAwesomeIcons.percent,
                  size: 17.sp,
                  color: Colors.grey,
                )),
            SizedBox(height: 15.sp),
            CustomTextFieldWidget(
              width: 35.w,
              title: 'Tenure',
              autofocus: false,
              hint: isyear ? "Enter Tenure in years" : 'Enter Tenure in Months',
              controller: tenure,
              focusNode: tenurenode,
              onFieldSubmitted: (val) {
                getEMI();
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "tenure required";
                }
                return null;
              },
              suffix: Text(isyear ? "Years" : "Months"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text("Year"),
                    selected: isyear,
                    onSelected: (value) {
                      setState(() {
                        isyear = value;
                        gotEMI = false;
                      });
                    },
                    selectedColor: Colors.amber,
                    disabledColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  ChoiceChip(
                    label: const Text("month"),
                    selected: !isyear,
                    onSelected: (value) {
                      setState(() {
                        isyear = false;
                        gotEMI = false;
                      });
                    },
                    selectedColor: Colors.amber,
                    disabledColor: Colors.white,
                  )
                ],
              ),
            ),
            SizedBox(height: 20.sp),
            InkWell(
              onTap: () {
                getEMI();
              },
              child: Container(
                height: 6.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10.sp)),
                child: Center(
                  child: Text(
                    "Get EMI",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.sp),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  outputBox() {
    return gotEMI
        ? Container(
            height: 25.h,
            width: 100.w,
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(
              color: const Color(0xffbd5837),
              // gradient: LinearGradient(
              //   colors: [
              //     const Color(0xffbd5837).withOpacity(1.0),
              //     const Color(0xffbd5837).withOpacity(0.5),
              //   ],
              //   begin: AlignmentDirectional.topStart,
              //   end: AlignmentDirectional.bottomEnd,
              // ),
              borderRadius: BorderRadius.all(Radius.circular(10.sp)),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "EMI  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21.sp,
                            color: Colors.white),
                      ),
                      const Icon(
                        FontAwesomeIcons.indianRupeeSign,
                        color: Colors.white,
                      ),
                      Text(
                        " " + results,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21.sp,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Total Interest Paid  :   ",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      Icon(
                        FontAwesomeIcons.indianRupeeSign,
                        color: Colors.white,
                        size: 15.sp,
                      ),
                      Text(
                        totalinterest.toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Total Amount Paid   :  ",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      Icon(
                        FontAwesomeIcons.indianRupeeSign,
                        color: Colors.white,
                        size: 15.sp,
                      ),
                      Text(
                        overAll.toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    "Effective rate /annum ",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  Text(
                    "Effective rate /month",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ]),
          )
        : SizedBox(
            width: 10.sp,
          );
  }
}

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) onFieldSubmitted;
  final String? Function(String?) validator;
  final Widget suffix;
  final String hint;
  final bool autofocus;
  final String title;
  final double width;
  final Widget child;
  const CustomTextFieldWidget(
      {Key? key,
      required this.controller,
      required this.child,
      required this.width,
      required this.title,
      required this.hint,
      required this.autofocus,
      required this.focusNode,
      required this.onFieldSubmitted,
      required this.validator,
      required this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp)),
        SizedBox(
          width: 15.sp,
        ),
        SizedBox(
          width: width,
          child: TextFormField(
              autofocus: autofocus,
              style: const TextStyle(fontWeight: FontWeight.bold),
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              controller: controller,
              onFieldSubmitted: onFieldSubmitted,
              validator: validator,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 15.sp),
                suffix: suffix,
                filled: true,
                fillColor: Colors.grey.shade200,
                errorStyle: const TextStyle(
                  color: Color(0xffbd5837),
                ),
                // border:
                //     OutlineInputBorder(borderRadius: BorderRadius.circular(15.sp)),
                hintText: hint,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 15.sp),
              )),
        ),
        child
      ],
    );
  }
}
