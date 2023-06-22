import 'package:cached_network_image/cached_network_image.dart';
import 'package:docotg/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserPostCard extends StatefulWidget {
  final snap;

  const UserPostCard({super.key, this.snap});

  @override
  State<UserPostCard> createState() => _UserPostCardState();
}

class _UserPostCardState extends State<UserPostCard> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(right: 6),
      child: Column(
        children: [
          Expanded(
            child: Container(
              // height: height * 0.21,
              // width: width * 0.4,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: blueTint),
              child: Column(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: widget.snap['photoUrl'],
                      height: height * 0.165,
                      width: width * 0.35,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        highlightColor: Colors.white,
                        baseColor: Colors.grey.shade100,
                        direction: ShimmerDirection.ttb,
                        period: const Duration(milliseconds: 700),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.person_rounded,
                        color: screenBgColor,
                        size: 150,
                      ),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.snap['fname'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: darkPurple),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
