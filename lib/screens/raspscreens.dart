import 'dart:collection';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/rendering.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';

import 'package:weekly_date_picker/weekly_date_picker.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weekly Date Picker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Weekly Date Picker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedDay = DateTime.now();
  var animation_start = true;
  var pda_chet = {
    '2023-02-09': {
      ', Лекция Физика 1-207, Пр.Зан. Физика  4-308, Лекция Механика  12р, Пр.Зан. Механика  102в,Занятий нет,'
    },
    '2023-02-10': [
      ',Лекция Физика   1-206, Пр.Зан. Физика    4-308,Занятий нет,Занятий нет,Занятий нет,'
    ],
    '2023-02-11': {
      ',Занятий нет ,Занятий нет ,Лекция Информаника и И.Т. ст.преп.    2-101,Пр.Зан. Физра ст.преп.    Спортзал,Занятий нет,'
    },
    '2023-02-12': {
      ',Занятий нет,Занятий нет,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-02-13': [
      ',Занятий нет,Лекция Социология   13р,Пр.Зан. Социология   302б,Занятий нет,Занятий нет,'
    ],
    '2023-02-14': {
      ',Лекция Высшая математика    5-207,Лекция Высшая математика    5-207,Лекция В.О.В: без срока давности* 21р,Занятий нет,Занятий нет,'
    },
    '2023-02-15': {
      ',Занятий нет,Занятий нет,Пр.Зан. Физра    Спортзал,Лекция Химия и авиаГСМ     12р,Иностранный язык Занятия в подгруппах,'
    },
    '2023-02-16': {
      ',Занятий нет,Занятий нет,Лекция Механика     12р,Пр.Зан. Механика    102в,Занятий нет,'
    },
    '2023-02-17': {
      ',Лекция Физика 1-206, Пр.Зан. Физика 4-308,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-02-18': {
      ',Занятий нет,Занятий нет, Лекция Информатика и И.Т. 1-214, Пр.Зан. Физра Спортзал,Занятий нет,'
    },
    '2023-02-19': {
      ',Занятий нет,Занятий нет,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-02-20': {
      ',Занятий нет,Лекция Социология 13р,Пр.Зан. Социология 302б,Занятий нет,Занятий нет,'
    },
    '2023-02-21': {
      ',Лекция Высшая математика 5-207,Пр.Зан. Высшая математика 5-207,Лекция В.О.В: без срока давности* 21р,Пр.Зан. В.О.В: без срока давности* 21р,Занятий нет,'
    },
    '2023-02-22': {
      ',Занятий нет, Пр.Зан. В.О.В: без срока давности* 13р,Пр.Зан. Физра Спортзал, Лекция Химия и авиаГСМ 12р,Пр.Зан. Иностранный язык 302а,'
    },
    '2023-02-23': {
      ',Занятий нет,Занятий нет,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-02-24': {
      ',Занятий нет,Занятий нет,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-02-25': {
      ',Занятий нет,Занятий нет, Лекция Информатика и И.Т. 2-101,Пр.Зан Физра Спортзал,Пр.Зан Час наставника 4р,'
    },
    '2023-02-26': {
      ',Занятий нет,Занятий нет,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-02-27': {
      ',Занятий нет,Лекция Социология 13р,Пр.Зан. Социология 302б,Занятий нет,Занятий нет,'
    },
    '2023-02-28': {
      ',Лекция Высшая математика 5-207,Пр.Зан. Высшая математика 5-207,Лекция В.О.В: без срока давности* 21р,Занятий нет,Занятий нет, '
    },
    '2023-03-01': {
      ',Занятий нет,Занятий нет,Пр.Зан. Физра Спортзал,Лекция Химия и авиаГСМ 12р,Пр.Зан. Иностранный язык 302а,'
    },
    '2023-03-02': {
      ',Лекция Физика 1-206,Пр.Зан Физика 4-308,Лекция Механика 12р, Пр.Зан. Механика 102В,Занятий нет,'
    },
    '2023-03-03': {
      ',Лаб.раб. Химия и авиаГСМ 507в,Лаб.раб. Химия и авиаГСМ 507в,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-03-04': {
      ',Занятий нет,Занятий нет,Лекция Информатика и И.Т. 2-101,Пр.Зан. Физра Спортзал,Занятий нет,'
    },
    '2023-03-05': {
      ',Занятий нет,Занятий нет,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-03-06': {
      ',Занятий нет,Лекция Социология 13р,Пр.Зан. Социология 302б,Занятий нет,Занятий нет,'
    },
    '2023-03-07': {
      ',Лекция Социология 13р,Пр.Зан. Социология 302б,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-03-08': {
      ',Лекция Высшая математика 5-207,Пр.Зан. Высшая математика 5-207, Лекция В.О.В: без срока давности* 21р,Занятий нет,Занятий нет,'
    },
    '2023-03-09': {
      ',Лекция Физика 1-206,Пр.Зан Физика 4-308,Лекция Механика 12р, Пр.Зан. Механика 102В,Занятий нет,'
    },
    '2023-03-10': {
      ',Лаб.раб. Химия и авиа ГСМ 507в,Лаб.раб. Химия и авиаГСМ 507в,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-03-11': {
      ',Занятий нет,Занятий нет, Лекция Информатика и И.Т. 2-101,Пр.Зан. Физра Спортзал,Занятий нет,'
    },
    '2023-03-12': {
      ',Занятий нет,Занятий нет,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-03-13': {
      ',Занятий нет, Лекция Социология 13р, Пр.Зан. Социология 302б,Занятий нет,Занятий нет,'
    },
    '2023-03-14': {
      ',Лекция Высшая математика 5-207,Пр.Зан. Высшая математика 5-207,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-03-15': {
      ',Занятий нет,Занятий нет,Лекция Физра 19р, Лекция Химия и авиаГСМ 12р,Пр.Зан. Иностранный язык 302а,'
    },
    '2023-03-16': {
      ',Лекция Физика 1-206,Пр.Зан Физика 4-308,Лекция Механика 12р, Пр.Зан. Механика 102В,Занятий нет,'
    },
    '2023-03-17': {
      ',Лаб.раб. Информатика и И.Т. 2-108,Лаб.раб. Информатика и И.Т. 2-108,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-03-18': {
      ',Занятий нет,Лекция Информатика и И.Т. 10р,Пр.Зан. Информатика и И.Т. 10р,Лекция Физра 9р,Занятий нет,'
    },
    '2023-03-19': {
      ',Занятий нет,Занятий нет,Занятий нет,Занятий нет,Занятий нет,'
    },
    '2023-03-20': {
      ',Занятий нет, Лекция Социология 13р,Пр.Зан. Социология 302б,Занятий нет,Занятий нет,'
    },
    '2023-03-21': {',,'},
    '2023-03-22': {',,'},
    '2023-03-23': {',,'},
    '2023-03-24': {',,'},
    '2023-03-25': {',,'},
    '2023-03-26': {',,'},
    '2023-03-27': {',,'},
    '2023-03-28': {',,'},
    '2023-03-29': {',,'},
    '2023-03-30': {',,'},
    '2023-03-31': {',,'},
    '2023-04-01': {',,'},
    '2023-04-02': {',,'},
    '2023-04-03': {',,'},
    '2023-04-04': {',,'},
    '2023-04-05': {',,'},
    '2023-04-06': {',,'},
    '2023-04-07': {',,'},
    '2023-04-08': {',,'},
    '2023-04-09': {',,'},
    '2023-04-10': {',,'},
    '2023-04-11': {',,'},
    '2023-04-12': {',,'},
    '2023-04-13': {',,'},
    '2023-04-14': {',,'},
    '2023-04-15': {',,'},
    '2023-04-16': {',,'},
    '2023-04-17': {',,'},
    '2023-04-18': {',,'},
    '2023-04-19': {',,'},
    '2023-04-20': {',,'},
    '2023-04-21': {',,'},
    '2023-04-22': {',,'},
    '2023-04-23': {',,'},
    '2023-04-24': {',,'},
    '2023-04-25': {',,'},
    '2023-04-26': {',,'},
    '2023-04-27': {',,'},
    '2023-04-28': {',,'},
    '2023-04-29': {',,'},
    '2023-04-30': {',,'},
    '2023-05-01': {',,'},
    '2023-05-02': {',,'},
    '2023-05-03': {',,'},
    '2023-05-04': {',,'},
    '2023-05-05': {',,'},
    '2023-05-06': {',,'},
    '2023-05-07': {',,'},
    '2023-05-08': {',,'},
    '2023-05-09': {',,'},
    '2023-05-10': {',,'},
    '2023-05-11': {',,'},
    '2023-05-12': {',,'},
    '2023-05-13': {',,'},
    '2023-05-14': {',,'},
    '2023-05-15': {',,'},
    '2023-05-16': {',,'},
    '2023-05-17': {',,'},
    '2023-05-18': {',,'},
    '2023-05-19': {',,'},
    '2023-05-20': {',,'},
    '2023-05-21': {',,'},
    '2023-05-22': {',,'},
    '2023-05-23': {',,'},
    '2023-05-24': {',,'},
    '2023-05-25': {',,'},
    '2023-05-26': {',,'},
    '2023-05-27': {',,'},
    '2023-05-28': {',,'},
    '2023-05-29': {',,'},
    '2023-05-30': {',,'},
    '2023-05-31': {',,'},
    '2023-06-01': {',,'},
    '2023-06-02': {',,'},
    '2023-06-03': {',,'},
    '2023-06-04': {',,'},
    '2023-06-05': {',,'},
    '2023-06-06': {',,'},
    '2023-06-07': {',,'},
    '2023-06-08': {',,'},
    '2023-06-09': {',,'},
    '2023-06-10': {',,'},
    '2023-06-11': {',,'},
    '2023-06-12': {',,'},
    '2023-06-13': {',,'},
    '2023-06-14': {',,'},
    '2023-06-15': {',,'},
    '2023-06-16': {',,'},
    '2023-06-17': {',,'},
    '2023-06-18': {',,'},
    '2023-06-19': {',,'},
    '2023-06-20': {',,'},
    '2023-06-21': {',,'},
    '2023-06-22': {',,'},
    '2023-06-23': {',,'},
    '2023-06-24': {',,'},
    '2023-06-25': {',,'},
    '2023-06-26': {',,'},
    '2023-06-27': {',,'},
    '2023-06-28': {',,'},
    '2023-06-29': {',,'},
    '2023-06-30': {',,'},
    '2023-07-01': {',,'},
    '2023-07-02': {',,'},
    '2023-07-03': {',,'},
    '2023-07-04': {',,'},
    '2023-07-05': {',,'},
    '2023-07-06': {',,'},
    '2023-07-07': {',,'},
    '2023-07-08': {',,'},
    '2023-07-09': {',,'},
    '2023-07-10': {',,'},
    '2023-07-11': {',,'},
    '2023-07-12': {',,'},
    '2023-07-13': {',,'},
    '2023-07-14': {',,'},
    '2023-07-15': {',,'},
    '2023-07-16': {',,'},
    '2023-07-17': {',,'},
    '2023-07-18': {',,'},
    '2023-07-19': {',,'},
    '2023-07-20': {',,'},
    '2023-07-21': {',,'},
    '2023-07-22': {',,'},
    '2023-07-23': {',,'},
    '2023-07-24': {',,'},
    '2023-07-25': {',,'},
    '2023-07-26': {',,'},
    '2023-07-27': {',,'},
    '2023-07-28': {',,'},
    '2023-07-29': {',,'},
    '2023-07-30': {',,'},
    '2023-07-31': {',,'},
  };
  //para_coc
  String paras1 = '1 занятие';
  String paras2 = '2 занятие';
  String paras3 = '3 занятие';
  String paras4 = '4 занятие';
  String paras5 = '5 занятие';
  //opaciti box
  bool _visible = true;

  String oper_paras = 'Занятий';

  //time para
  String time_pars1 = '8:30 - 10:00';
  String time_pars2 = '10:10 - 11:40';
  String time_pars3 = '12:40 - 14:10';
  String time_pars4 = '14:20 - 15:50';
  String time_pars5 = '16:00 - 16:30';
  //para auditorion
  String auditorion1 = '';
  String auditorion2 = '';
  String auditorion3 = '';
  String auditorion4 = '';
  String auditorion5 = '';
  //name_para_kk
  String name_para_kk1 = '';
  String name_para_kk2 = '';
  String name_para_kk3 = '';
  String name_para_kk4 = '';
  String name_para_kk5 = '';
  //int row count parent
  int mechanik_kackes_otstup1 = 0;
  int mechanik_kackes_otstup2 = 0;
  int mechanik_kackes_otstup3 = 0;
  int mechanik_kackes_otstup4 = 0;
  int mechanik_kackes_otstup5 = 0;

  int counter_par = 0;
  String datess = '';
  String datessing = '';
  String peremennay_vrem = '';
  String number1 = '';
  String number2 = '';
  String number3 = '';
  String number4 = '';
  String number5 = '';
  String text_rast = '';
  //date
  String data_mesack = '';
  String god_mesack = '';
  String data_int = '';

  String mesacs = '';
  String mesacs_name = '';
//void
  void date() {
    datess = _selectedDay.toString();
    List<String> result = datess.split(' ');
    datessing = result[0];
  }

  void status_name_para_konecs() {
    if (counter_par == 0) {
      oper_paras = 'занятий';
    }

    if (counter_par == 1) {
      oper_paras = 'занятие';
    }
    if (counter_par == 2) {
      oper_paras = 'занятия';
    }
    if (counter_par == 3) {
      oper_paras = 'занятия';
    }
    if (counter_par == 4) {
      oper_paras = 'занятия';
    }
    if (counter_par == 5) {
      oper_paras = 'занятий';
    }
  }

  void set_mesacs() async {
    setState(() {
      mesacs = datessing;
      var kjk = mesacs.split('-');
      data_int = kjk[2];
      data_mesack = kjk[1];
      god_mesack = kjk[0];
      if (kjk[1] == '01') {
        mesacs_name = 'Январь';
      }
      if (kjk[1] == '02') {
        mesacs_name = 'Февраль';
      }
      if (kjk[1] == '03') {
        mesacs_name = 'Март';
      }
      if (kjk[1] == '04') {
        mesacs_name = 'Апрель';
      }
      if (kjk[1] == '05') {
        mesacs_name = 'Май';
      }
      if (kjk[1] == '06') {
        mesacs_name = 'Июнь';
      }
      if (kjk[1] == '07') {
        mesacs_name = 'Июль';
      }
      if (kjk[1] == '08') {
        mesacs_name = 'Август';
      }
    });
  }

  void mainskun(datessing) async {
    peremennay_vrem = pda_chet['$datessing'].toString();
    var sacking = peremennay_vrem.split(',');
    var sacking2 = [];
    setState(() {
      number1 = sacking[1];
      //print(number1);
      number2 = sacking[2];
      //print(number2);
      number3 = sacking[3];
      //print(number3);
      number4 = sacking[4];
      //print(number4);
      number5 = sacking[5];
      //print(number5);
    });
  }

  void auditorions() {
    if (number1 != 'Занятий нет') {
      var strkn = number1.split(' ');
      auditorion1 = strkn[strkn.length - 1];
      name_para_kk1 = strkn[strkn.length - strkn.length];
      mechanik_kackes_otstup1 = 40;
    }
    if (number2 != 'Занятий нет') {
      var strkn = number2.split(' ');
      auditorion2 = strkn[strkn.length - 1];
      name_para_kk2 = strkn[strkn.length - strkn.length];
      mechanik_kackes_otstup2 = 40;
    }
    if (number3 != 'Занятий нет') {
      var strkn = number3.split(' ');
      auditorion3 = strkn[strkn.length - 1];
      name_para_kk3 = strkn[strkn.length - strkn.length];
      mechanik_kackes_otstup3 = 40;
    }
    if (number4 != 'Занятий нет') {
      var strkn = number4.split(' ');
      auditorion4 = strkn[strkn.length - 1];
      name_para_kk4 = strkn[strkn.length - strkn.length];
      mechanik_kackes_otstup4 = 40;
    }
    if (number5 != 'Занятий нет') {
      var strkn = number5.split(' ');
      auditorion5 = strkn[strkn.length - 1];
      name_para_kk5 = strkn[strkn.length - strkn.length];
      mechanik_kackes_otstup5 = 40;
    }
  }

  void counter_parsing() async {
    setState(() {
      if (number1 != 'Занятий нет') {
        counter_par += 1;
      }
      if (number2 != 'Занятий нет') {
        counter_par += 1;
      }
      if (number3 != 'Занятий нет') {
        counter_par += 1;
      }
      if (number4 != 'Занятий нет') {
        counter_par += 1;
      }
      if (number5 != 'Занятий нет') {
        counter_par += 1;
      }
      if (counter_par == 0) {}
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date();
    set_mesacs();
    mainskun(datessing);
    counter_parsing();
    auditorions();
    status_name_para_konecs();
    _visible = !_visible;
    Future.delayed(Duration(milliseconds: 550), () {
      setState(() {
        _visible = !_visible;
      });
    });
  }

//widget
  Widget _text_raspisanie_widget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 20),
      child: Text(
        'Расписание',
        style: TextStyle(color: Colors.black45, fontSize: 15),
      ),
    );
  }

  Widget _text_mecase_widget(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 244, 243, 249),
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _text_raspisanie_widget(context),
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: Text(
              '$mesacs_name',
              style: TextStyle(color: Colors.black45, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _weeklydata_widget(BuildContext context) {
    return WeeklyDatePicker(
      selectedDay: _selectedDay,
      changeDay: (value) => setState(() {
        _selectedDay = value;
        _visible = !_visible;
        datess = _selectedDay.toString();
        counter_par = 0;
        auditorion1 = '';
        auditorion2 = '';
        auditorion3 = '';
        auditorion4 = '';
        auditorion5 = '';

        //asd
        mechanik_kackes_otstup1 = 0;
        mechanik_kackes_otstup2 = 0;
        mechanik_kackes_otstup3 = 0;
        mechanik_kackes_otstup4 = 0;
        mechanik_kackes_otstup5 = 0;

        //name para
        name_para_kk1 = '';
        name_para_kk2 = '';
        name_para_kk3 = '';
        name_para_kk4 = '';
        name_para_kk5 = '';

        set_mesacs();
        date();
        mainskun(datessing);
        counter_parsing();
        status_name_para_konecs();
        auditorions();

        Future.delayed(Duration(milliseconds: 550), () {
          setState(() {
            _visible = !_visible;
          });
        });
      }),
      enableWeeknumberText: false,
      weeknumberColor: Color.fromARGB(255, 178, 29, 207),
      weeknumberTextColor: Color.fromARGB(255, 37, 37, 37),
      backgroundColor: Color.fromARGB(255, 244, 243, 249),
      weekdayTextColor: const Color(0xFF8A8A8A),
      digitsColor: Color.fromARGB(255, 43, 43, 43),
      selectedBackgroundColor: Color.fromARGB(255, 134, 100, 255),
      weekdays: ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"],
      daysInWeek: 7,
    );
  }

  Widget _Card1(BuildContext context) {
    return _CardRaspis_Widget(context, number1, paras1, time_pars1, auditorion1,
        name_para_kk1, mechanik_kackes_otstup1);
  }

  Widget _Card2(BuildContext context) {
    return _CardRaspis_Widget(context, number2, paras2, time_pars2, auditorion2,
        name_para_kk2, mechanik_kackes_otstup2);
  }

  Widget _Card3(BuildContext context) {
    return _CardRaspis_Widget(context, number3, paras3, time_pars3, auditorion3,
        name_para_kk3, mechanik_kackes_otstup3);
  }

  Widget _Card4(BuildContext context) {
    return _CardRaspis_Widget(context, number4, paras4, time_pars4, auditorion4,
        name_para_kk4, mechanik_kackes_otstup4);
  }

  Widget _Card5(BuildContext context) {
    return _CardRaspis_Widget(context, number5, paras5, time_pars5, auditorion5,
        name_para_kk5, mechanik_kackes_otstup5);
  }

  Widget _peredparami(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Text(
              '$counter_par $oper_paras,  $data_int.$data_mesack.$god_mesack'),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width - 240,
              top: 10,
              bottom: 10),
          child: Container(
            height: 36,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        size: 19,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 36,
            width: 40,
            child: TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        size: 19,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
              onPressed: () {
                Share.text(
                    'my text title',
                    'This is my text to share with other applications.',
                    'text/plain');
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _CardRaspis_Widget(BuildContext context, text_rast, para_count,
      time_pars, auditorians, name_para, otstup) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 100,
        child: Card(
          //margin: EdgeInsets.all(10),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                width: 3,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 233, 232, 238),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "$para_count : $name_para",
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Container(
                      //     child: Text("$time_pars"),
                      //   ),
                      // ),

                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width % 6 +
                                150 -
                                otstup),
                        child: Text(
                          "$time_pars",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Преподаватель",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width - 212),
                        child: Text(
                          "$auditorians",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    set_mesacs();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 243, 249),
      body: Column(
        children: [
          _text_mecase_widget(context),
          _weeklydata_widget(context),
          _peredparami(context),
          _Card1(context),
          _Card2(context),
          _Card3(context),
          _Card4(context),
          _Card5(context),
        ],
      ),
    );
  }
}
