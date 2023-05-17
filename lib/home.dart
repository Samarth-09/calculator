import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int count = 0;

  //map gives values entered by the user, key:-index of the butotns in gridview, value:- actuall value at that index
  Map<int, dynamic> mp = {
    0: 'c',
    1: '%',
    2: 'bksp',
    3: '/',
    4: 7,
    5: 8,
    6: 9,
    7: '*',
    8: 4,
    9: 5,
    10: 6,
    11: '-',
    12: 1,
    13: 2,
    14: 3,
    15: '+',
    16: '00',
    17: 0,
    18: '.',
    19: '='
  };

  // list of the icons(buttons in the calculator)
  var iconslist = [
    Icon(Mdi.alphaC),
    Icon(Mdi.percentOutline),
    Icon(Mdi.backspaceOutline),
    Icon(Mdi.division),
    Icon(Mdi.numeric7),
    Icon(Mdi.numeric8),
    Icon(Mdi.numeric9),
    Icon(Mdi.multiplication),
    Icon(Mdi.numeric4),
    Icon(Mdi.numeric5),
    Icon(Mdi.numeric6),
    Icon(Mdi.minus),
    Icon(Mdi.numeric1),
    Icon(Mdi.numeric2),
    Icon(Mdi.numeric3),
    Icon(Mdi.plus),
    Icon(Mdi.circleDouble),
    Icon(Mdi.numeric0),
    Icon(Mdi.circleSmall),
    Icon(Mdi.equal)
  ];

  late var d1 = '', d2 = '', op = '';
  var ans = 0.0, r = '';

  late SharedPreferences pref;
  void fun() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    fun();
  }

  // function for the calculation and set the content of the display
  void calculate(int index) {
    setState(() {
      if (mp[index].toString() == '=') {
        if (op == '') {
          ans = double.parse(d1);
        }
        if (op == '/') {
          ans = double.parse(d1) / double.parse(d2);
        } else if (op == '*') {
          ans = double.parse(d1) * double.parse(d2);
        } else if (op == '+') {
          ans = double.parse(d1) + double.parse(d2);
        } else if (op == '-') {
          ans = double.parse(d1) - double.parse(d2);
        }
        pref.setString('$count', r);
        r = ans.toString();
        d1 = ans.toString();
        op = '';
        d2 = '';
        count++;
      } else if (mp[index].toString() == 'c' ||
          mp[index].toString() == 'bksp' ||
          mp[index].toString() == '/' ||
          mp[index].toString() == '%' ||
          mp[index].toString() == '*' ||
          mp[index].toString() == '+' ||
          mp[index].toString() == '-') {
        if (mp[index].toString() == 'c') {
          d1 = '';
          d2 = '';
          ans = 0;
          op = '';
          r = '';
        } else if (mp[index].toString() == 'bksp') {
          if (op == '') {
            r = r.substring(0, r.length - 1);
            d1 = r;
          } else {
            r = r.substring(0, r.length - 1);
            if (d2 != '') d2 = d2.substring(0, d2.length - 1);
          }
        } else if (mp[index].toString() == '%') {
          if (op == '')
            d1 = (double.parse(d1.toString()) * 0.01).toString();
          else
            d2 = (double.parse(d2.toString()) * 0.01).toString();
          r += mp[index];
        } else {
          r += mp[index];
          op = mp[index];
        }
      } else {
        if (mp[index].toString() == '.' || mp[index].toString() == '00') {
          if (op == '') {
            d1 += mp[index];
          } else {
            d2 += mp[index];
          }
          r += mp[index];
        } else {
          r += mp[index].toString();
          if (op == '')
            d1 += mp[index].toString();
          else
            d2 += mp[index].toString();
        }
      }
    });
  }

  // function that defines the single button of calculator
  Widget button(int index) {
    bool check =
        (index <= 3 || index == 7 || index == 11 || index == 15 || index == 19)
            ? true
            : false;
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: (check) ? Color.fromARGB(255, 114, 113, 113) : Colors.black12,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10)),
      child: IconButton(
          color: Colors.white,
          onPressed: () {
            calculate(index);
            HapticFeedback.heavyImpact();
          },
          icon: iconslist[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
          backgroundColor: Colors.black,
          leading: Builder(
            builder: (context) {
              return IconButton(
                  icon: Icon(Icons.history, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
            }
          )),
      drawer: Drawer(
          backgroundColor: Colors.black54,
          child: ListView.builder(
              itemCount: count,
              itemBuilder: ((context, index) {
                var s = pref.getString('$index');
                print(s);
                return Text(s!,
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.1));
              }))),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
              height: height * 0.30,
              child: Center(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    HapticFeedback.heavyImpact();
                  });
                },
                child: Text(r,
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.1)),
              ))),
          Container(
            alignment: Alignment.bottomCenter,
            height: height * 0.56,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              //p+ing: EdgeInsets.all(10),
              itemCount: iconslist.length,
              itemBuilder: (BuildContext context, int index) {
                return button(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
