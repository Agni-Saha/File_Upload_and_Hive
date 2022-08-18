import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:file_upload/models/audio_models.dart';
import 'package:file_upload/pages/uploading_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box? hiveBox;

  @override
  void initState() {
    super.initState();
    hiveBox = Hive.box("audio_box");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back),
        actions: [
          Image.asset(
            "assets/Menu 2.png",
            width: 32,
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Image.asset(
                "assets/taxi-magician.png",
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              "Upload File",
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
              "Browse and choose the files \nyou want to upload",
              style: GoogleFonts.ptSans(
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                var navigator = Navigator.of(context);
                addFile(navigator);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFFFFCC27),
                ),
                child: const Icon(
                  Icons.add,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addFile(navigator) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', "aac"],
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      var now = DateTime.now();
      String date = now.toString().substring(0, 10);

      AudioModel audio = AudioModel(
        title: file.name,
        date: date,
      );

      hiveBox!.add(audio.toMap());
    }

    navigator.push(
      MaterialPageRoute(
        builder: (_) => const UploadingState(),
      ),
    );
  }
}
