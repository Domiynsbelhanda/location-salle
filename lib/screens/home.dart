import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:place_event/screens/root_app.dart';
import 'package:provider/provider.dart';
import '../models/rooms.dart';
import '../services/auth.dart';
import '../services/datas.dart';
import '../theme/color.dart';
import '../utils/constant.dart';
import '../widgets/city_item.dart';
import '../widgets/feature_item.dart';
import '../widgets/recommend_item.dart';
import '../widgets/user_box.dart';
import 'authentification/login_screen.dart';
import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final storage = new FlutterSecureStorage();

  TextEditingController search = new TextEditingController();


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            automaticallyImplyLeading: false,
            title: getAppBar(),
          ),
          SliverToBoxAdapter(
            child: buildBody(),
          ),
        ],
      ),
    );
  }

  Widget getAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/logo1.png',
          scale: 1.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: ()=>urlLaunch('https://twitter.com/domiyns'),
              child: Icon(
                FontAwesomeIcons.twitter,
                color: Colors.black,
                size: width(context) / 20,
              ),
            ),

            SizedBox(
              width: 8.0,
            ),

            GestureDetector(
                onTap: ()=>urlLaunch('https://www.instagram.com/younessdominique/'),
                child: Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.black,
                  size: width(context) / 20,
                )
            ),

            SizedBox(
              width: 8.0,
            ),

            GestureDetector(
                onTap: ()=>urlLaunch('https://www.linkedin.com/in/youness-dominique-tshunza-6005b7a1/'),
                child: Icon(
                  FontAwesomeIcons.linkedin,
                  color: Colors.black,
                  size: width(context) / 20,
                )
            ),

            SizedBox(
              width: 8.0,
            ),

            Consumer<Auth>(
              builder: (context, auth, child){
                return Consumer<Datas>(
                builder: (context, datas, child){
                  return UserBox(
                    //auth.user.email
                    notifiedNumber: auth.authenticated ? 1 : 0,
                    onTap: () {
                      if(auth.authenticated){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                                RootApp(tab: 3, error: false, user: auth.user, rooms: datas.rooms,))
                        );
                      } else {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      }
                    },
                  );
                });
              },
            )
          ],
        ),
      ],
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Container(
                  height: width(context) /1.8,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                      image: AssetImage("assets/images/bg.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(width(context) / 40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Trouver une salle pour tous vos événements.',
                          style: TextStyle(
                              fontSize: width(context) / 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        SizedBox(height: width(context) / 50),

                        Text(
                          'Bénéficiez jusqu\'à 10% de réduction.',
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),

                        SizedBox(height: width(context) / 20),

                        Consumer<Datas>(
                          builder: (context, datas, child){
                            return GestureDetector(
                              onTap: ()=>Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RootApp(
                                  error: false,
                                  tab: 1,
                                  rooms: datas.rooms,
                                )),
                              ),
                              child: Container(
                                height: width(context) / 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white.withOpacity(0.4),
                                  border: Border.all(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 1.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rechercher',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: tertColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
              ),
            ),
            getCities(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Text(
                "Populaires en ce moment",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
            ),
            getFeature(),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nos recommendations",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: textColor),
                  )
                ],
              ),
            ),
            getRecommend(),
          ],
        ),
      ),
    );
  }

  getFeature() {
    return Consumer<Datas>(
      builder: (context, datas, child){
        try{
          return CarouselSlider(
            options: CarouselOptions(
              height: 312,
              enlargeCenterPage: true,
              disableCenter: true,
              viewportFraction: .75,
            ),
            items: List.generate(
              datas.rooms.length < 6 ? datas.rooms.length : 6,
                  (index) => FeatureItem(
                data: datas.rooms[index],
                onTapFavorite: () {
                  setState(() {
                    // features[index]["is_favorited"] =
                    // !features[index]["is_favorited"];
                  });
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Details(
                      data: datas.rooms[index],
                    )),
                  );
                },
              ),
            ),
          );
        } catch (e){
          return SizedBox();
        }
      },
    );
  }

  getRecommend() {
    return Consumer<Datas>(
      builder: (context, datas, child){
        try{
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                datas.rooms.length,
                    (index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: RecommendItem(
                    data: datas.rooms[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Details(
                          data: datas.noted[index],
                        )),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        } catch(e){
          return SizedBox();
        }
      },
    );
  }

  getCities() {
    return Consumer<Datas>(
      builder: (context, datas, child){
        try{
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                datas.categories.length,
                    (index) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CityItem(
                    data: datas.categories[index],
                    onTap: () {
                      List<Rooms>? allRooms = datas.rooms;
                      List<Rooms>? contains = [];
                      allRooms.forEach((room) {
                        room.categories?.forEach((categorie) {
                          if(categorie['slug'] == datas.categories[index].slug){
                            contains.add(room);
                          }
                        });
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RootApp(
                          error: false,
                          tab: 1,
                          rooms: contains,
                        )),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        } catch(e){
          return SizedBox();
        }
      },
    );
  }
}
