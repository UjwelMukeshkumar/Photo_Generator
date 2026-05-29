import 'package:flutter/material.dart';
import 'package:generator/Controller/home_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: const  Color(0xff212121),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
             const   SizedBox(height: 30),
                Text(
                  "Intuitive Ai",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                  ),
                ),
            const    SizedBox(height: 30),
                Container(
                  height: 320,
                  width: 320,
                  decoration: BoxDecoration(
                    color: const Color(0xff424242),
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Consumer<HomeProvider>(
                    builder: (context, provider, child) => provider
                            .searchChanging
                        ? provider.imageData != null
                            ? Image.memory(provider.imageData!)
                            : const  Center(child: CircularProgressIndicator())
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined,
                                  color: Colors.grey[400], size: 90),
                              Text(
                                'No image is generated.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
               const SizedBox(height: 40),
                Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color:const  Color(0xff424242),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: homeProvider.textController,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                    ),
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter Your Prompt Here...",
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 15,
                        fontFamily: GoogleFonts.openSans().fontFamily,
                      ),
                      contentPadding: const EdgeInsets.all(8.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        homeProvider.textToImage(
                            homeProvider.textController.text, context);
                        homeProvider.loadingUpdate(true);
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.greenAccent,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Consumer<HomeProvider>(
                          builder: (context, provider, child) {
                            return provider.isLoading == false
                                ? Text(
                                    'Generate',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.openSans().fontFamily,
                                    ),
                                  )
                                : const CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        homeProvider.searchUpdate(false);
                        homeProvider.textController.clear();
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.redAccent,
                              Colors.orangeAccent,
                            ],
                          ),
                        ),
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.openSans().fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
