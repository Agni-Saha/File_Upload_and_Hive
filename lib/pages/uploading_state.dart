import 'package:file_upload/pages/uploaded_files.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadingState extends StatelessWidget {
  const UploadingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    navigate(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/taxi-waiting.png",
              width: MediaQuery.of(context).size.width * 2,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              "Uploading...",
              style: GoogleFonts.crimsonPro(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Please wait a moment while \nwe upload your files",
              style: GoogleFonts.ptSans(
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void navigate(BuildContext context) {
    var navigator = Navigator.of(context);
    Future.delayed(
      const Duration(seconds: 5),
    ).then(
      (value) => navigator.push(
        MaterialPageRoute(
          builder: (_) => const UploadedFiles(),
        ),
      ),
    );
  }
}
