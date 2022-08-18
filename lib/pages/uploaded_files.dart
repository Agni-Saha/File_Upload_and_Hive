import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:file_upload/models/audio_models.dart';
import 'package:file_upload/pages/home_page.dart';

class UploadedFiles extends StatelessWidget {
  const UploadedFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
          },
          backgroundColor: const Color(0xFFFFCC27),
          child: const Icon(Icons.arrow_forward),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              SearchBar(),
              BottomContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/Path 2.png"),
          fit: BoxFit.fill,
        ),
      ),
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: 96,
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Search for File by name or type",
          hintStyle: GoogleFonts.crimsonPro(),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          suffixIcon: const Icon(
            Icons.search_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class BottomContainer extends StatefulWidget {
  const BottomContainer({Key? key}) : super(key: key);

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  final List<String> navList = [
    "Photos",
    "Videos",
    "Audios",
    "Documents",
  ];
  List<bool> isSelected = [false, false, true, false];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Navbar(
            isSelected: isSelected,
            navList: navList,
            notifier: changeSelected,
          ),
          const SizedBox(
            height: 24,
          ),
          const ItemCard(),
        ],
      ),
    );
  }

  void changeSelected(int index) {
    setState(() {
      for (int i = 0; i < navList.length; i++) {
        isSelected[i] = false;
      }
      isSelected[index] = true;
    });
  }
}

class Navbar extends StatelessWidget {
  final List<bool> isSelected;
  final List<String> navList;
  final Function(int) notifier;

  const Navbar({
    Key? key,
    required this.isSelected,
    required this.navList,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        itemCount: navList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              notifier(index);
            },
            child: Padding(
              padding: (index != navList.length - 1)
                  ? const EdgeInsets.only(
                      left: 25,
                    )
                  : const EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
              child: Text(
                navList[index],
                style: GoogleFonts.ptSans(
                  color:
                      (isSelected[index] == true) ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  Box? hiveBox;

  @override
  void initState() {
    super.initState();
    hiveBox = Hive.box("audio_box");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      child: buildItemCards(),
    );
  }

  // Widget audioList() {
  //   return FutureBuilder(
  //     future: Hive.openBox("audio_box"),
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       if (snapshot.hasData) {
  //         hiveBox = snapshot.data;
  //         return buildItemCards();
  //       } else {
  //         return Container(
  //           alignment: Alignment.center,
  //           child: const Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }

  Widget buildItemCards() {
    List audios = hiveBox!.values.toList();

    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      shrinkWrap: true,
      itemCount: audios.length,
      itemBuilder: (context, index) {
        var audio = AudioModel.fromMap(audios[index]);

        return GestureDetector(
          onLongPress: () {
            hiveBox!.deleteAt(index);
            setState(() {});
          },
          child: Container(
            height: 10,
            width: 10,
            padding: const EdgeInsets.only(
              left: 16,
            ),
            decoration: BoxDecoration(
              color: (index == audios.length - 1)
                  ? const Color(0xFFFFCC27).withOpacity(0.8)
                  : const Color(0xFFFFCC27).withOpacity(0.4),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Voice\nRecording\n${audio.title.substring(0, 10)}",
                  style: GoogleFonts.crimsonPro(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1,
                    height: 0.8,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  audio.date,
                  style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
