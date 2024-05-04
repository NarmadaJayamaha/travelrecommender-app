import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class DestinationCard extends StatefulWidget {
  final dynamic data;
  const DestinationCard({super.key, required this.data});

  @override
  State<DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard> {

  void _openGoogleMaps() async {
    final double latitude = double.parse(widget.data['latitude']);
    final double longitude = double.parse(widget.data['longitude']);

    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    print(googleMapsUrl);
    await launch(googleMapsUrl);

    // if (await canLaunch(googleMapsUrl)) {
    //   await launch(googleMapsUrl);
    // } else {
    //   throw 'Could not launch $googleMapsUrl';
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dynamic item = widget.data;
    return Container(
      width: size.width,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: (size.width/2.35),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 218, 255, 232),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item['image'],
              width: size.width/4,
              height: size.width/3,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: size.width - (size.width/2.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: size.width - (size.width/2),
                          child: Text(
                            item['address'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    item['phone_number'] != null ? Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: size.width - (size.width/2),
                          child: Text(
                            item['phone_number'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ) : Container(),
                    const SizedBox(height: 5),
                    RatingBar.builder(
                      initialRating: double.parse(item['rating'].toString()),
                      minRating: 1,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                width: size.width - (size.width/2.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        _openGoogleMaps();
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.directions,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    item['phone_number'] != null ? GestureDetector(
                      onTap: () {
                        launch("tel://${item['phone_number']}");
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}