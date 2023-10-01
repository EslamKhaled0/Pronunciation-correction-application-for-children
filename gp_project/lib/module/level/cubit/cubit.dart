// import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/module/level/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubitLevel1 extends Cubit<AppStates> {
  AppCubitLevel1() : super(AppInitialState());
  static AppCubitLevel1 get(context) => BlocProvider.of(context);

  List<String> materials1 = [
    'الف',
    'باء',
    'تاء',
    'ثاء',
    'جيم',
    'حاء',
    'خاء',
    'دال',
    'ذال',
    'راء',
    'زاي',
    'سين',
    'شين',
    'صاد',
    'ضاد',
    'طاء',
    'ظاء',
    'عين',
    'غين',
    'فاء',
    'قاف',
    'كاف',
    'لام',
    'ميم',
    'نون',
    'هاء',
    'واو',
    'ياء',
  ];
  List<String> materials2 = [
    'صفر',
    'واحد',
    'اثنان',
    'ثلاث',
    'أربعة',
    'خمس',
    'ستة',
    'سبعة',
    'ثمانية',
    'تسعة',
  ];
  List<String> materials3 = [
    'أحمر',
    'أخضر',
    'أزرق',
    'برتقالي',
    'أصفر',
    'بنفسجي',
    'أسود',
    'أبيض',
    'بني',
    'رمادي',
    'وردي',
  ];
  List<String> materials4 = [
    'موز',
    'برتقال',
    'تفاح',
    'فراولة',
    'بطيخ',
    'عنب',
    'اناناس',
    'طماطم',
    'خس',
    'جزر',
    'باذنجان',
    'بطاطا',
    'بصل',
    'ثوم',
    'خيار',
    'فلفل',
    'يقطين',
    'ذرة',
    'بازلاء',
  ];
  List<String> materials5 = [
    'طبيب',
    'شرطي',
    'رائد فضاء',
    'فلاح',
    'خباز',
    'رجل إطفاء',
    'ساعي البريد',
    'معلم',
    'طيار',
    'جزار',
  ];
  List<String> materials6 = [
    'أسد',
    'أرنب',
    'بطة',
    'تمساح',
    'ثعلب',
    'قط',
    'حصان',
    'جمل',
    'خروف',
    'كلب',
    'زرافة',
    'غزال',
    'قرد',
  ];
  List<String> materials7 = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
    'السبت',
    'الأحد',
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];
  List<String> materials8 = [
    'أبي',
    'أمي',
    'أختي',
    'أخي',
    'جدي',
    'جدتي',
    'عمي',
    'عمتي',
    'خالي',
    'خالتي',
  ];
  List<String> materials9 = [
    'قدم',
    'ساق',
    'يد',
    'ذراع',
    'بطن',
    'صدر',
    'كتف',
    'رقبة',
    'رأس',
    'وجه',
    'فم',
    'أنف',
    'عين',
    'أذن',
    'شعر',
  ];
  List<String> materials10 = [
    'فصل الشتاء',
    'فصل الخريف',
    'فصل الربيع',
    'فصل الصيف',
  ];
  List<String> materials11 = [
    'حاسة البصر',
    'حاسة الذوق',
    'حاسة السمع',
    'حاسة الشم',
    'حاسة اللمس',
  ];
  List<String> materials12 = [
    'ذهب حمزة إلي المسجد',
    'أكل حمزة التفاح',
    'إستيقظ حمزة',
    'نظر المبرمج إلي الحاسوب',
    'لعب الطفل في الملعب',
  ];

  bool loading = true;
  static Database? database1;
  List<Map> locks1 = [];
  bool createDatabase1() {
    openDatabase(
      'checking1.db',
      version: 1,
      onCreate: (database, version) {
        //id integer
        //status String
        print('database created');
        database
            .execute(
          'CREATE TABLE locks1 (id INTEGER PRIMARY KEY AUTOINCREMENT, level1 INTEGER, level2 INTEGER, level3 INTEGER, level4 INTEGER, level5 INTEGER, level6 INTEGER, level7 INTEGER, level8 INTEGER, level9 INTEGER, level10 INTEGER, level11 INTEGER, level12 INTEGER, user_id INTEGER UNIQUE)',
        )
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase1(database);
        print('database opened');
      },
    ).then((value) {
      database1 = value;
      emit(AppCreateDatabaseState1());
    });
    return true;
  }
  void insertToDatabase1(String table ,Map<String,Object> values) async {
    openDatabase(
      'checking1.db',
      version: 1,
    );

    await database1?.transaction((txn) {
      txn
          .insert(table, values)
          .then((value) {
        print(' $value inserted successfully');
        emit(AppInsertDatabaseState1());
        getDataFromDatabase1(database1);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
      return Future.value();
    });
  }
  void getDataFromDatabase1(database) {
    loading = true;
    locks1 = [];
    // print('got data');
    if (database != null) {
      emit(AppGetDatabaseLoadingState1());

      database.rawQuery('SELECT * FROM locks1').then((value) {
        value.forEach((element) {
          locks1.add(element);
        });
        emit(AppGetDatabaseState1());
      });
    }
    loading = false;
  }
  void updateDatabase1(String table, Map<String,Object> values, String? mywhere) async {
    database1?.update(table, values, where: mywhere).then((value) {
      getDataFromDatabase1(database1);
      emit(AppUpdateDatabaseState1());
    });
  }
}
