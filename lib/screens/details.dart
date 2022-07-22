import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/color.dart';
import '../utils/constant.dart';
import '../utils/data.dart';
import '../widgets/city_item.dart';
import '../widgets/custom_image.dart';
import '../widgets/feature_item.dart';
import '../widgets/notification_box.dart';
import '../widgets/recommend_item.dart';

class Details extends StatefulWidget {
  Details({Key? key, this.data}) : super(key: key);
  final data;

  @override
  State<Details> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<Details> {

  TextEditingController search = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Stack(
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 16.0,
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                      return primaryColor;
                    },
                  )
                ),
                onPressed: () {  },
                child: Text(
                    "RESERVER",
                  style: TextStyle(
                    fontSize: 20.0
                  ),

                ),
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: buildBody()

              ),
            ],
          ),
        ],
      ),
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
                  FontAwesomeIcons.arrowLeftLong,
                  color: Colors.black,
                )
            ),
            SizedBox(
              height: 10,
            ),

            getFeature(),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Text(
                '${widget.data["name"]}',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: textColor),
              ),
            ),

            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                widget.data["type"],
                style: TextStyle(fontSize: 12, color: labelColor),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: yellow,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    widget.data["rate"],
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  SizedBox(width: 8.0,),
                  Text(
                    widget.data["price"],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 16, 0, 0),
              child: Text(
                widget.data["description"],
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getFeature() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220,
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .75,
      ),
      items: List.generate(
        widget.data["album_images"].length,
            (index) => Container(
              width: 280,
              height: 220,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 5, top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImage(
                    widget.data["image"],
                    width: double.infinity,
                    height: 190,
                    radius: 15,
                  )
                ],
              ),
            ),
      ),
    );
  }
}
