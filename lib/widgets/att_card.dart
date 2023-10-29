import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AttCard extends StatelessWidget {
  final String subject;
  final int totalLecs;
  final int attended;
  final int bunked;
  final double percentage;
  final VoidCallback function;
  const AttCard(
      {super.key,
      required this.function,
      required this.percentage,
      required this.subject,
      required this.totalLecs,
      required this.attended,
      required this.bunked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 20.h,
      decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 20),
                child: Text(
                  subject,
                  style: GoogleFonts.acme(fontSize: 35),
                ),
              ),
              IconButton(
                onPressed: function,
                icon: const Icon(Icons.more_vert),
                iconSize: 35,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "$bunked / ",
                  style: GoogleFonts.acme(fontSize: 25),
                ),
                Text(
                  "$attended / ",
                  style: GoogleFonts.acme(fontSize: 25),
                ),
                Text(
                  "$totalLecs  ",
                  style: GoogleFonts.acme(fontSize: 25),
                ),
                Text(
                  "($percentage %)",
                  style: GoogleFonts.acme(fontSize: 25),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
