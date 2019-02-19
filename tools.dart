import 'package:flutter/material.dart';
import 'dart:convert' as converter;
import 'main.dart';
import 'start.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:convert/convert.dart' as ccs;

String root_url="https://unschool.com.tr/";
Map cookie={};
Map _data={'md':'x','usr':'','yet':''};

String get_data(String arg){
    return _data[arg];
}

void save_data(String str,String val){
  _data[str]=val;
}

Map get_cookie(){
  return cookie;
}

String cookieGet(String key){
  String res='';
  var obj=cookie[key];
  if(obj != null){
    res=obj.toString();
  }
  return res;
}

void cookieSave(String dat){
  String str;
  str=dat;
  print(str);
  if(str.isNotEmpty && str !=null){
    var v1,v2,v3,v4,v5,v6;
    List<String> st=str.split(",");
      for(v1 in st){
        List<String> v2=v1.toString().trim().replaceAll(" ","").split(";");
        for(v3 in v2){//print("t:" + v3);
          if(v3.indexOf(new RegExp(r'=')) != -1 && v3.length > 0){
            List<String> v4=v3.split("=");
            if(v4.length > 0){
              v5=v4[0].toString().trim().toLowerCase().replaceAll("-", "");
              v6=v4[1].toString().trim();
              //print("s:" + v5);
              if(v5 != 'path' && v5 != 'expires' && v5 != 'maxage' && v5.isNotEmpty && !v5.toString().contains(':')){
                //print(v5);
                cookie[ v5 ]=v6;
              }
            }
          }
        }

      }
  }
}


Container txt (str,{Color txtColor = Colors.black,double padd=0,double txtSize=17}){
  return new Container(
    padding: EdgeInsets.all(padd),
    child: new Text(str,style: TextStyle(fontSize: txtSize,color: txtColor),),
  );
}

void gotoPage(t,Widget ctx){
  Navigator.push(t, new MaterialPageRoute(builder: (t) => ctx),);
}

void modalAc(context,title,msg,{bool disable = true}){
  showDialog<void>(
    context: context,
    barrierDismissible: disable, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(msg),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void modalConfirm(BuildContext t,String title,String msg,String btnText,VoidCallback actionBtn){
  showDialog<void>(
    context: t,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(title: Text(title,style: TextStyle(color: Colors.blueGrey,fontSize: 14),),
      contentPadding: EdgeInsets.all(0),
        content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0,20,0,20),
          child: Text(msg, textAlign: TextAlign.center),
        ),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FlatButton(padding: EdgeInsets.all(3),
            child: Text(btnText,style: TextStyle(fontSize: 14),),
            onPressed: actionBtn,
          ),
          FlatButton(padding: EdgeInsets.all(3),
              child: Text('Close',style: TextStyle(fontSize: 14)),
              onPressed: () {Navigator.of(context).pop();})
        ])
        ],
      ),
      );
    },
  );
}

Map <String, dynamic> jsonParse(String str){
  Map<String, dynamic> val=converter.jsonDecode(str);
  return val;
}


RoundedRectangleBorder borderShape(double bor){
  return new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(bor));
}

BorderRadius borRadius(double s){
  return BorderRadius.all(Radius.circular(s));
}

Column inputText(String placeholder,
    {double inputsize=16,
      double borderRadius=5,
      double titleSize=16,
      TextInputType type=TextInputType.text,
      double padding=7,
      TextEditingController control,bool pass=false}){
  return Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(placeholder,style: TextStyle(fontSize: titleSize),)
      ,TextField(controller: control,maxLines: 1,
        keyboardType: type,autofocus: true,obscureText: pass
        ,style: new TextStyle(fontSize: inputsize)
        ,decoration: InputDecoration(fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.all( padding ),
            border:OutlineInputBorder(borderRadius: borRadius(7))
        ),
      )
    ],);
}

void showLoader(BuildContext t){
  double size=55;
  showDialog<void>(
    context: t,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(title: Center(child:Text('wait..',style: TextStyle(color: Colors.blueGrey,fontSize: 14),),),
        contentPadding: EdgeInsets.all(0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/loader2.gif"),fit: BoxFit.fitHeight)),
              padding: EdgeInsets.fromLTRB(0,20,0,20),
            ), Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FlatButton(padding: EdgeInsets.all(3),
                    child: Text('...',style: TextStyle(fontSize: 14,color: Colors.grey),),
                    onPressed: (){},
                  ),
                  FlatButton(
                      padding: EdgeInsets.all(3),
                      child: Text('Close',style: TextStyle(fontSize: 14)),
                      onPressed: () {Navigator.of(context).pop();}
                      )
                ]
            )
          ],
        ),
      );
    },
  );
}

String vidUrl({String str='ornek'}){
  return root_url + 'videoizle/?p='+ str;
}

String rootUrl(String str){
  return root_url;
}

BoxDecoration backimg(){
  return BoxDecoration(
      //color: Colors.blueGrey,
      image: DecorationImage(
      image: new ExactAssetImage('assets/back_1.jpg'),
  fit: BoxFit.cover,
  ),
  );
}

List<String> popMenuItems = <String>[
  "FavoriListem",
  "Bildirimler",
  "Profil",
  "Ayar",
  "Çıkış"
];

PopupMenuButton popuMenu(BuildContext t,List<String> items,{Icon icn,String str="",Color col=Colors.white,double fsize=15}){
  Widget chld;
  TextStyle st=TextStyle(color: col,fontSize: fsize);
  if(str.isNotEmpty){
    chld=Text(str,style: st,);
  }
  return PopupMenuButton<String>(icon: icn,
    onSelected: (val) => func_click_onMenu(t,val),child: chld,
    itemBuilder: (BuildContext context){
      return items.map((String choice){
        return PopupMenuItem<String>(
          value: choice,
          child: Text(choice),
        );
      }).toList();
    },
  );
}

Row topLogo(BuildContext t){
  bool varsa=false;
  if(cookie.isNotEmpty){varsa=true;}

  Row menu_1=Row(children: <Widget>[
    Visibility(visible: varsa,
      child:Container(
        margin: EdgeInsets.all(5),
        child: IconButton(icon: Icon(Icons.menu,color: Colors.white,size: 26,), onPressed: (){showYanMenu(t);}),
        //popuMenu(t,popMenuItems,icn: Icon(Icons.menu,size: 27,color: Colors.white,)),
      ),
    )
  ],);

  Row menu_2=Row(children: <Widget>[
    Visibility(visible: varsa,
      child:Container(
      margin: EdgeInsets.all(5),
      child: IconButton(icon: Icon(Icons.power_settings_new,color: Colors.white,size: 26,) ,
          onPressed: ()=> oturumConfirm(t)
      ),
      ),
    )
  ],);


  return new Row(children: <Widget>[
    new Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Color.fromARGB(155,2, 2, 2),blurRadius: 5,offset: Offset(0, 7))],
            image: new DecorationImage( image: AssetImage("assets/intro.jpg"),repeat: ImageRepeat.repeat,fit: BoxFit.fill )
        ),
        width: MediaQuery.of(t).size.width,
        padding: EdgeInsets.all(0),
        alignment: Alignment.center,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          menu_1,
          Image.asset("assets/logo.png",width: 144,),
          menu_2,
        ],)
    )
  ],
  );
}

OverlayEntry ovEntyr=OverlayEntry(builder: (BuildContext context) {return MenuOverlay();});

void showYanMenu(BuildContext t){
  Navigator.of(t).overlay.insert(ovEntyr);
}

void DisableYaMenu(BuildContext t){
  ovEntyr.remove();
}

class HexColor extends Color{
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

void func_click_onMenu(BuildContext t,String str){
  var v1,v2;
  switch(str){
    case "Çıkış": oturumConfirm(t); break;
  }
}

void oturumKapat(BuildContext t){
  cookie.clear();
  gotoPage(t, MyHomePage());
}

void oturumConfirm(BuildContext t){
  modalConfirm(t, "Çıkış?", "ÇIKMAK\nİSTİYORMUSUNUZ?","Oturum Kapat",()=>oturumKapat(t));
}

class FunkyOverlay extends StatefulWidget {
  String str="";
  FunkyOverlay({Key key, @required this.str}) : super(key: key);
  @override
  State<StatefulWidget> createState() => FunkyOverlayState(this.str);

}

class FunkyOverlayState extends State<FunkyOverlay> with SingleTickerProviderStateMixin{
  String str;
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimatoin;

  FunkyOverlayState(this.str);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.8).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    scaleAnimatoin = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {
      });
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Text childElement=Text(this.str);
    return Material(type: MaterialType.card,
      color: Colors.black.withOpacity(opacityAnimation.value),
      child: Center(
        child: ScaleTransition(
          scale: scaleAnimatoin,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: childElement,
            ),
          ),
        ),
      ),
    );
  }
}


class MenuOverlay extends StatefulWidget {
  MenuOverlay({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MenuOverlayState();

}

class MenuOverlayState extends State<MenuOverlay> with SingleTickerProviderStateMixin{
  Container element;
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimatoin;
  Animation<double> posV1;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.8).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    scaleAnimatoin = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    posV1=Tween(begin: -200.0, end: 0.0).animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    controller.addListener(() {
      setState(() {
      });
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){DisableYaMenu(context);},
        child:  Material(type: MaterialType.card,
          color: Colors.black.withOpacity(opacityAnimation.value),
          child: Transform(
            transform: Matrix4.translationValues(posV1.value,0,0),
            child: GestureDetector(onTap: (){print("t2");},
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                    Container(color: Colors.white54,padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                      width: MediaQuery.of(context).size.width/1.8,height: MediaQuery.of(context).size.height,
                      child: Column(children: <Widget>[
                        Row(mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                DisableYaMenu(context);
                              },
                              child: Container(
                                width: 35,
                                decoration: BoxDecoration(borderRadius: borRadius(5),color: Colors.redAccent,),
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: Text("X",style: TextStyle(color: Colors.white,fontSize: 14),),
                                ),
                              ),
                            )
                          ],),
                        Center(
                          child: Container(
                            width: 100,height: 100,
                            //color:Colors.white,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(100),border: Border.all(color: Colors.grey,width: 3)
                              ,image: new DecorationImage( image: AssetImage('assets/default-logo.png'), ) ,
                            ) ,
                          ),
                        ),Center(child:
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: txt( cookieGet('u_cook_loginad',),txtSize: 11 ),
                            color: Colors.white30,
                          )
                        ),
                        add_Menu("AnaSayfa",(){
                          String s='as';
                          String nm=cookieGet('u_cook_loginad');
                          //String sfc=ccs.hex.encode('admin');
                          //print(String.fromCharCode() );
                          DisableYaMenu(context);
                          gotoPage(context, MyStartPage());
                          String sf=cookieGet('u_cook_loginad');

                        }),
                        add_Menu("Ayar",(){
                          DisableYaMenu(context);
                        }),
                        add_Menu("Çıkış",(){
                          DisableYaMenu(context);
                          oturumConfirm(context);
                        }),
                      ],),
                    )
                  ]
              ),
            )
          ),
        )
    );
  }
}

String hexToStr(String raw) {
  var str = '';
  int v1;
  String s1;
  for (int n = 0; n < raw.length; n += 2) {
    v1 = int.parse(raw.substring(n, n+2), radix: 16);
    str += String.fromCharCode(v1);
    //str += String.fromCharCode(parseInt(raw, 16));
  }
  return str;
}

Column add_Menu(String str,VoidCallback vc){
  return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
    children:<Widget>[
      GestureDetector(
          onTap: vc,
          child: Container(decoration:BoxDecoration(color: Colors.white70,borderRadius: borRadius(5)),
            padding: EdgeInsets.all(7),
            margin: EdgeInsets.fromLTRB(5,2,5,2),
            child: Text(str,style: TextStyle(fontSize: 17),),
          )
      ),
    ],
  );
}

Future NotifCreate(String title,String msg) async{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  var android = AndroidInitializationSettings('@mipmap/ic_launcher');
  var ios = IOSInitializationSettings();
  var setNotif = InitializationSettings(android, ios);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(setNotif);

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      playSound: true, importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics =
  new IOSNotificationDetails(presentSound: true);
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, title,msg, platformChannelSpecifics,payload: 'Default_Sound');

}

double getSize(BuildContext t,String mod){
  Size mq=MediaQuery.of(t).size;
  double res=0;
  if(mod == 'w'){
    res=mq.width;
  }else{
    res=mq.height;
  }
  return res;
}

void debugLogin(BuildContext t){
  String raw="{connection: keep-alive, x-powered-by: PHP/7.0.32, set-cookie: PHPSESSID=finuvceagbsgoiu9h0noq67vd4; expires=Fri, 06-Sep-2019 13:29:00 GMT; Max-Age=17280000; path=/; secure; HttpOnly,u_cook_loginad=61734061732E636F6D; expires=Fri, 06-Sep-2019 13:29:00 GMT; Max-Age=17280000; path=/,u_cook_logind=1; expires=Fri, 06-Sep-2019 13:29:00 GMT; Max-Age=17280000; path=/,set_key=deleted; expires=Thu, 01-Jan-1970 00:00:01 GMT; Max-Age=0; path=/,md=6; expires=Fri, 06-Sep-2019 13:29:00 GMT; Max-Age=17280000; path=/,set_name=admin; expires=Fri, 06-Sep-2019 13:29:00 GMT; Max-Age=17280000; path=/, cache-control: no-store, no-cache, must-revalidate, date: Mon, 18 Feb 2019 13:29:00 GMT, content-length: 0, pragma: no-cache, content-type: text/html; charset=UTF-8, server: openresty, expires: Thu, 19 Nov 1981 08:52:00 GMT}";
  cookieSave(raw);
  gotoPage(t, MyStartPage());
}
