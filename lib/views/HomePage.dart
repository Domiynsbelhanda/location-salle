import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:place_event/functions/api.dart';
import 'package:place_event/functions/global_variable.dart';
import 'package:place_event/views/ListHotels.dart';
import 'package:place_event/widgets/categorie.dart';
import 'package:place_event/widgets/rooms.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>{

  TextEditingController search = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1.5,
                            ),
                          ),
                          child: Expanded(
                            child: TextField(
                              controller: search,
                              style: TextStyle(
                                  color: tertColor,
                                  fontSize: width(context) / 23
                              ),
                              decoration: InputDecoration(
                                hintText: '  Rechercher',
                                hintStyle: TextStyle(
                                  color: tertColor,
                                  fontSize: width(context) / 23
                                ),
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    if(search.text.trim().isNotEmpty){
                                      Navigator.of(context)
                                          .push(
                                          createRoute(context, ListItem(query : search.text.trim())
                                          )
                                      );
                                    }
                                  },
                                  icon: Icon(
                                      FontAwesomeIcons.magnifyingGlass,
                                    color: tertColor,
                                  )
                                )
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),

                SizedBox(height: width(context) / 15),

                Text(
                  'Catégories',
                  style: TextStyle(
                    fontSize: width(context) / 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff142919)
                  ),
                ),

                SizedBox(height: width(context) / 25),

                SizedBox(
                  height: width(context) / 9,
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context)
                              .push(
                              createRoute(context, ListItem(categorie : categories[index].name,)
                              )
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: categorieItem(context, categories[index]),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: width(context) / 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Plus des salles',
                      style: TextStyle(
                          fontSize: width(context) / 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff142919)
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.of(context)
                            .push(
                            createRoute(context, ListItem(rooms: rooms,)
                            )
                        );
                      },
                      child: Text(
                        'Voir Plus',

                      ),
                    )
                  ],
                ),

                SizedBox(height: width(context) / 25),

                SizedBox(
                    height: height(context) / 4,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: rooms.length,
                    itemBuilder: (item, index){
                      return GestureDetector(
                        onTap: (){
                        },
                        child: widgetRooms(context, rooms[index])
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}