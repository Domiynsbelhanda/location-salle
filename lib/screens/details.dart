import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:place_event/screens/authentification/login_screen.dart';
import 'package:place_event/services/datas.dart';
import 'package:provider/provider.dart';
import '../models/rooms.dart';
import '../services/auth.dart';
import '../theme/color.dart';
import '../utils/constant.dart';
import '../widgets/custom_image.dart';
import 'package:intl/intl.dart';

class Details extends StatefulWidget {
  Details({Key? key, required this.data}) : super(key: key);
  final Rooms data;

  @override
  State<Details> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<Details> {

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Stack(
        children: [
          Positioned(
            top: 16.0,
            left: 15.0,
            child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
                  FontAwesomeIcons.arrowLeftLong,
                  color: Colors.black,
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: buildBody()

                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8.0,
            child: Container(
              width: width(context) / 1.00,
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          bool auth = Provider.of<Auth>(context, listen: false).authenticated;
                          if(auth){
                            reservation_dialog(context);
                          } else {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => LoginScreen()));
                          }
                        },
                        child: Container(
                          height: width(context) / 9,
                          width: width(context) / 1.28,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                            color: primaryColor
                          ),
                          child: Center(
                            child: Text(
                              "Réserver",
                              style: TextStyle(
                                  fontSize: 20.0,
                                color: Colors.white
                              ),

                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          await FlutterShare.share(
                              title: 'Place Event',
                              text: 'Salle : ${widget.data.title}',
                              linkUrl: 'https://place-event.com/roomsParty/${widget.data.key}',
                              chooserTitle: ''
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          child: Icon(
                            FontAwesomeIcons.share,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ]
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  reservation_dialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("ANNULER"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget plusButton = TextButton(
      child: Text("CONFIRMER"),
      onPressed: () {
        Map data = {
          'id':5,
          'phones': _phoneController.text,
          'date' : _dateController.text,
          'keys' : widget.data.key
        };
        if(_formKey.currentState!.validate()){
          bool auth = Provider.of<Auth>(context, listen: false).authenticated;
          if(auth){
            Navigator.pop(context);
            Provider.of<Datas>(context, listen: false).reservation(creds: data, context: context);
          } else {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Reservation Salle'),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Téléphone',
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _phoneController,
                  keyboardType : TextInputType.phone,
                  validator: (value) => value!.isEmpty ? 'Veuillez entrer un numéro valide' : null,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Enter your phone number",
                      fillColor: Colors.white70,
                  ),
                ),

                SizedBox(height: 16.0),

                Text(
                  'Date de reservation',
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _dateController,
                  keyboardType: TextInputType.datetime,
                  validator: (value) => value!.isEmpty ? 'Veuillez entrer une date valide' : null,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Enter your date",
                      fillColor: Colors.white70,
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                  ),
                  readOnly: true,
                  onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2020), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100)
                  );
              
                  if(pickedDate != null ){
                    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              
                    setState(() {
                      _dateController.text = formattedDate; //set output date to TextField value. 
                    });
                  }else{
                    showAlertDialog(context, 'Date de reservation', 'Erreur, recommencer.');
                  }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        okButton,
        plusButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            getFeature(),
            SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Container(
                child: Text(
                  '${widget.data.title}',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star,
                    size: 20,
                    color: yellow,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    '${widget.data.note}',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(width: 16.0,),
                  Text(
                    'Max : ${widget.data.places} place(s)',
                    style: TextStyle(fontSize: 15, color: labelColor),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${widget.data.prices} \$',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: 16.0,),
                  Text(
                    'Max : ${widget.data.town}',
                    style: TextStyle(
                        fontSize: 15, color: Colors.blueGrey
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width / 1.05,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 16, 0, 0),
                child: Text(
                  '${widget.data.description}',
                  style: TextStyle(
                      fontSize: 16, color: Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.0,),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.locationDot,
                    color: Colors.deepPurple,
                    size: width(context) / 7,
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Adresse',
                        style: TextStyle(
                            fontSize: 18,
                            color: textColor),
                      ),
                      Text(
                        '${widget.data.address}',
                        style: TextStyle(
                            fontSize: 20,
                            color: textColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
              child: Container(
                child: Text(
                  'Information sur la salle',
                  style: TextStyle(
                      fontSize: 18,
                      color: textColor),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Table(

                border: TableBorder.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1
                ),
                children: [
                  TableRow( children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Adresse'),
                          )
                        ]
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${widget.data.address}'),
                          )
                        ]
                    ),
                  ]),
                  TableRow( children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Commune'),
                          )
                        ]
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${widget.data.commune}'),
                          )
                        ]
                    ),
                  ]),
                  TableRow( children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Ville'),
                          )
                        ]
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${widget.data.town}'),
                          )
                        ]
                    ),
                  ]),
                  TableRow( children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Capacité'),
                          )
                        ]
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${widget.data.places}'),
                          )
                        ]
                    ),
                  ]),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
              child: Container(
                child: Text(
                  'Contact de la salle',
                  style: TextStyle(
                      fontSize: 18,
                      color: textColor),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Table(

                border: TableBorder.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1
                ),
                children: [
                  TableRow( children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Téléphone'),
                          )
                        ]
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${widget.data.phones}'),
                          )
                        ]
                    ),
                  ]),
                  TableRow( children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Email'),
                          )
                        ]
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${widget.data.email}'),
                          )
                        ]
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getFeature() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.05,
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
              'https://place-event.com/public/storage/${widget.data.images}',
              width: double.infinity,
              height: 190,
              radius: 15,
            )
          ],
        ),
      ),
    );
  }
}
