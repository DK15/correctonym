import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_coverflow/simple_coverflow.dart';

void main() => runApp(MaterialApp(
      home: A(),
    ));

class Q {
  String t, c, w, wr;

  Q({this.t, this.c, this.w, this.wr});

  factory Q.fromJson(Map<String, dynamic> r) {
    return Q(t: r['t'], c: r['c'], w: r['w'], wr: r['wr']);
  }
}

class A extends StatefulWidget {
  @override
  _AS createState() => _AS();
}

class _AS extends State<A> {
  int cI = 0;

  List<Container> d = [
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/b.png'), fit: BoxFit.cover)),
            child: CoverFlow(
              dismissedCallback: ds,
              currentItemChangedCallback: (int i) {
                setState(() {
                  cI = i;
                });
              },
              itemCount: d.length,
              itemBuilder: (BuildContext c, int i) {
                return I(i, cI);
              },
            )));
  }

  ds(int i, DismissDirection dr) {
    d.removeAt(i % d.length);
  }
}

class I extends StatefulWidget {
  final int i, cI;

  I(this.i, this.cI);

  @override
  _IS createState() => _IS(i, cI);
}

class _IS extends State<I> {
  final int i, cI;

  bool _c = false;
  bool _w = false;
  bool _wr = false;

  _IS(this.i, this.cI);

  List<Q> l = List();

  F() async {
    l = new List<Q>();
    String j = await rootBundle.loadString('assets/acr.json');
    Map m = json.decode(j);
    var p = m['d'] as List;
    for (int i = 0; i < p.length; i++) {
      l.add(new Q.fromJson(p[i]));
    }
    if (this.mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    F();
  }

  @override
  Widget build(BuildContext c) {
    return l.length > 0
        ? Container(
            child: Card(
            color: Colors.transparent.withOpacity(0.3),
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 70),
                  child: Text(
                    l[i].t,
                    style: TextStyle(fontSize: 21, color: Colors.white),
                  )),
              Container(
                  height: 50,
                  child: GestureDetector(
                    child: Card(
                        color: _w ? Colors.red : Colors.white.withOpacity(0.1),
                        child: Center(
                            child: Text(
                          l[i].w,
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        ))),
                    onTap: () {
                      if (i == cI) {
                        setState(() {
                          _c = false;
                          _w = true;
                          _wr = false;
                        });
                      }
                    },
                  )),
              Container(
                  height: 50,
                  child: GestureDetector(
                    child: Card(
                        color:
                            _c ? Colors.green : Colors.white.withOpacity(0.1),
                        child: Center(
                            child: Text(
                          l[i].c,
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        ))),
                    onTap: () {
                      if (i == cI) {
                        setState(() {
                          _c = true;
                          _w = false;
                          _wr = false;
                        });
                      }
                    },
                  )),
              Container(
                  height: 50,
                  child: GestureDetector(
                    child: Card(
                        color: _wr
                            ? Colors.redAccent
                            : Colors.white.withOpacity(0.1),
                        child: Center(
                            child: Text(
                          l[i].wr,
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        ))),
                    onTap: () {
                      if (i == cI) {
                        setState(() {
                          _c = false;
                          _w = false;
                          _wr = true;
                        });
                      }
                    },
                  )),
            ]),
          ))
        : Container();
  }
}
