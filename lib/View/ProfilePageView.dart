import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lead_management_system/Utils/StyleData.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: HexColor("#F0EAD6"),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: _image != null
                          ? ClipOval(
                        child: Image.file(
                          _image!,
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Icon(
                        Icons.person,
                        size: 40,
                        color: StyleData.appBarColor2,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Text(
                      "",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.3,
            ),
            Center(
              child: Text(
                "Coming Soon"
              ),
            )
          ],
        ),
      ),
    );
  }
}
