import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:place_event/screens/authentification/login_screen.dart';
import 'package:place_event/services/datas.dart';
import 'package:provider/provider.dart';
import '../models/rooms.dart';
import '../services/auth.dart';
import '../theme/color.dart';
import '../utils/constant.dart';
import '../widgets/custom_image.dart';

class Details extends StatefulWidget {
  Details({Key? key, required this.data}) : super(key: key);
  final Rooms data;

  @override
  State<Details> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<Details> {

  TextEditingController search = new TextEditingController();

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
                      fillColor: Colors.white70
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
                      fillColor: Colors.white70
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        plusButton,
        okButton
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
                      fontWeight: FontWeight.w500,
                      color: textColor),
                ),
              ),
            ),

            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.town,
                        style: TextStyle(fontSize: 12, color: labelColor),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
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
                            '${widget.data.note}',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),

                          SizedBox(width: 8.0,),
                          Text(
                            '${widget.data.prices} \$',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Phone : (+243) ${widget.data.phones}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.data.places} place(s)',
                        style: TextStyle(fontSize: 12, color: labelColor),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${widget.data.address}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        '${widget.data.commune}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  )
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
                      fontSize: 14, color: Colors.black,

                  ),
                ),
              ),
            ),

            SizedBox(height: 16.0,),

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

            Center(
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
                onPressed: () {
                  bool auth = Provider.of<Auth>(context, listen: false).authenticated;
                  if(auth){
                    reservation_dialog(context);
                  } else {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                },
                child: Text(
                  "RESERVER",
                  style: TextStyle(
                      fontSize: 20.0
                  ),

                ),
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
