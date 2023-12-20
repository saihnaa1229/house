import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_fire/model/book_order.dart';
import 'package:test_fire/model/booking.dart';
import 'package:test_fire/model/employee.dart';
import 'package:test_fire/model/employee1.dart';
import 'package:test_fire/util/user.dart';
import 'package:test_fire/widgets/employee_card.dart';
import '../model/admin.dart';
import '../model/services.dart';
import '../model/user.dart';
import '../util/constants.dart';
import '../widgets/booking_item_card.dart';
import '../widgets/services_item_card.dart';
import 'package:path/path.dart' as path;

class HomeServices {
  Future<void> pickImageFromGallery(
    BuildContext context,
    String? collection,
    String? employeeId,
  ) async {
    final ImagePicker _picker = ImagePicker();

    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      uploadImageToFirebaseStorage(
          File(image.path), context, collection, employeeId);
    } else {
      // User canceled the picker
    }
  }

  Future<void> uploadImageToFirebaseStorage(
      File image, BuildContext context, String? collection, String? id) async {
    // Showing a loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('$collection/$id/${path.basename(image.path)}');

      await ref.putFile(image);

      String downloadURL = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection(collection!).doc(id).update({
        'photoURL': downloadURL,
      });

      Navigator.pop(context); // Close the loading indicator
    } catch (e) {
      Navigator.pop(context); // Close the loading indicator
      print(e); // Handle error

      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image: ${e.toString()}")),
      );
    }
  }

  static List<String> getCarouselItems() {
    List<String> temp = [];
    temp.add(
        'https://www.shutterstock.com/image-photo/basket-bucket-cleaning-items-on-260nw-1154607223.jpg');
    temp.add(
        'https://previews.123rf.com/images/wdnet/wdnet1806/wdnet180600047/105364144-healthy-eating-and-green-grocery-shopping-banner-group-of-selected-fresh-vegetables-on-abstract.jpg');
    temp.add(
        'https://media.istockphoto.com/id/1071027802/photo/fresh-vegetables-on-blurred-abstract-background.jpg?s=612x612&w=is&k=20&c=utwrb5kR74kTACb1sOLHp3RaY3AtzKLgoYw1EIelC48=');
    return temp;
  }

  static List<String> getServicesList() {
    List<String> temp = [
      'Цэвэрлэгээ',
      'Засвар',
      'Угаалга',
      'Цахилгаан хэрэгсэл',
      'Сантехник',
      'Гоо сайхан',
      'Массаж',
      'Будах'
    ];
    return temp;
  }

  static List<String> getBookingStatus() {
    List<String> temp = ['Хүлээгдэж байгаа', 'Баталгаажсан', 'Цуцалсан'];

    return temp;
  }

  static List<ServiceItemCard> getServiceItems() {
    List<ServiceItemCard> temp = [];
    for (int i = 0; i < 4; i++) {
      temp.add(serviceListItems[i]);
    }
    return temp;
  }

  static List<ServiceItemCard> getAllServiceItems() {
    List<ServiceItemCard> temp = [];
    for (int i = 0; i < serviceListItems.length; i++) {
      temp.add(serviceListItems[i]);
    }
    return temp;
  }

  Future<List<EmployeeCard>> getEmployeeDetails(String docId) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('category')
        .doc(docId)
        .collection('employees')
        .get();

    List<EmployeeCard> temp = [];

    for (var doc in querySnapshot.docs) {
      var element = Employee1.fromDocumentSnapshot(doc);
      temp.add(
        EmployeeCard(
          employeeId: doc.id,
          employee: element,
        ),
      );
    }
    return temp;
  }

  // List<BookingItemCard> getBookingDetails(int index) {
  //   List<BookingItemCard> temp = [];

  //   for (int i = 0; i < bookingList.length; i++) {
  //     if (bookingList[i].bookingitems.status == index) {
  //       temp.add(bookingList[i]);
  //     }
  //   }
  //   return temp;
  // }

  Future<List<EmployeeCard>> getAllEmployees() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('employee').get();

    if (querySnapshot.docs.isEmpty) {
      print('The employee collection is empty.');
      return [];
    }

    List<EmployeeCard> temp = [];
    for (var doc in querySnapshot.docs) {
      print('Processing document: ${doc.id}');
      try {
        var element = Employee1.fromDocumentSnapshot(doc);
        temp.add(
          EmployeeCard(
            employeeId: doc.id,
            employee: element,
          ),
        );
      } catch (e) {
        print('Error processing document ${doc.id}: $e');
      }
    }

    if (temp.isEmpty) {
      print('No EmployeeCard objects were created.');
      return [];
    }

    return temp;
  }

  Future<void> employeesByCategory() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot employeeSnapshot =
        await firestore.collection('employee').get();

    Map<String, List<DocumentSnapshot>> categoryGroups = {};
    for (var doc in employeeSnapshot.docs) {
      String category = doc['category'];
      categoryGroups.putIfAbsent(category, () => []).add(doc);
    }

    for (var category in categoryGroups.keys) {
      DocumentReference categoryRef =
          firestore.collection('category').doc(category);

      DocumentSnapshot categorySnapshot = await categoryRef.get();
      if (!categorySnapshot.exists) {
        await categoryRef.set({'name': category});
      }

      for (var employeeDoc in categoryGroups[category]!) {
        var data = employeeDoc.data();
        if (data is Map<String, dynamic>) {
          await categoryRef
              .collection('employees')
              .doc(employeeDoc.id)
              .set(data);
        } else {
          print('Document ${employeeDoc.id} has invalid data.');
        }
      }
    }
  }

  Future<void> addEmployee() async {
    for (var employee in employees) {
      try {
        // Create User Account
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: employee.email,
          password: employee.password,
        );

        String uid = userCredential.user!.uid;
        await FirebaseFirestore.instance
            .collection('employee')
            .doc(uid)
            .set(employee.toMap());

        await FirebaseFirestore.instance
            .collection('employee')
            .doc(uid)
            .set({'id': uid}, SetOptions(merge: true));

        print('Employee account and data added for: ${employee.fullName}');
      } catch (e) {
        print(
            'Error creating account or adding data for ${employee.fullName}: $e');
      }
    }
  }

  Future<Employee1> getEmployeeData(String employeeId) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('employee')
        .doc(employeeId)
        .get();

    if (docSnapshot.exists) {
      return Employee1.fromDocumentSnapshot(docSnapshot);
    } else {
      throw Exception('Employee not found');
    }
  }

  Future<UserModel> getUserData(String? userId) async {
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (docSnapshot.exists) {
      return UserModel.fromDocumentSnapshot(docSnapshot);
    } else {
      throw Exception('User not found');
    }
  }

  Future<Admin> getAdminData(String? userId) async {
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection('admin').doc(userId).get();

    if (docSnapshot.exists) {
      return Admin.fromDocumentSnapshot(docSnapshot);
    } else {
      throw Exception('User not found');
    }
  }

  Future<List<BookingItemCard>> getBookingsByStatus(String status) async {
    QuerySnapshot snapshot = await firestore
        .collection('users')
        .doc(UserPreferences.getUser())
        .collection('bookings')
        .where('status', isEqualTo: status)
        .get();

    List<BookingItemCard> temp = [];

    for (var doc in snapshot.docs) {
      var element = BookingModel.fromDocumentSnapshot(doc);
      temp.add(
        BookingItemCard(
          bookingitems: element,
        ),
      );
    }

    return temp;
  }

  Future<List<BookingItemCard>> getBookingBySelectedDay(
      String formattedDate) async {
    List<BookingItemCard> bookings = [];

    // Convert the formattedDate string back to a DateTime
    DateTime selectedDate = DateTime.parse(formattedDate);

    // Convert the DateTime to a Firestore Timestamp
    Timestamp selectedTimestamp = Timestamp.fromDate(selectedDate);

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(UserPreferences.getUser())
        .collection('bookings')
        .where('selectedDay', isEqualTo: selectedTimestamp)
        .get();

    // Convert each DocumentSnapshot into a BookingModel
    for (var doc in querySnapshot.docs) {
      var element = BookingModel.fromDocumentSnapshot(doc);
      bookings.add(
        BookingItemCard(
          bookingitems: element,
        ),
      );
    }
    return bookings;
  }
}

List<Employee1> employees = [
  Employee1(
    review: 120,
    rating: 3.5,
    fullName: 'Индра',
    email: 'indrab123@gmail.com',
    phoneNumber: '95237654',
    address: '10р хороолол',
    dateOfBirth: DateTime(1995, 02, 01),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Өрөө цэвэрлэгээ',
    category: 'Цэвэрлэгээ',
    password: '123456',
    salary: 50000,
    url:
        'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
    uploadedAt: DateTime(1995, 02, 01),
  ),
  Employee1(
    rating: 3.9,
    review: 105,
    fullName: 'Золзаяа',
    email: 'zoloozol@gmail.com',
    phoneNumber: '85534890',
    address: 'Хүннү хотхон',
    dateOfBirth: DateTime(1990, 10, 10),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Хувцас угаалга',
    category: 'Угаалга',
    salary: 55000,
    password: '23456',
    url:
        'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
    uploadedAt: DateTime(1990, 10, 10),
  ),
  Employee1(
    rating: 5.0,
    review: 200,
    fullName: 'Баатар',
    email: 'baatarunur1208@gmail.com',
    phoneNumber: '91321111',
    address: 'Зайсан',
    dateOfBirth: DateTime(1980, 12, 5),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Хивс угаалга',
    salary: 65000,
    category: 'Угаалга',
    password: 'Az88888',
    url:
        'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
    uploadedAt: DateTime(1980, 12, 5),
  ),
  Employee1(
    review: 135,
    rating: 3.3,
    fullName: 'Азбаяр',
    email: 'azbayr@gmail.com',
    phoneNumber: '99153463',
    address: 'Саппоро',
    dateOfBirth: DateTime(1990, 08, 12),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: ' Буйдан засвар',
    category: 'Засвар',
    password: '945638',
    salary: 40000,
    url:
        'https://www.hotelmogel.com/wp-content/uploads/2018/10/iStock-915418510.jpg',
    uploadedAt: DateTime(1990, 08, 12),
  ),
  Employee1(
    review: 125,
    rating: 3.9,
    fullName: 'Навчаа',
    email: 'navhch453@gmail.com',
    phoneNumber: '88850990',
    address: 'Жуков',
    dateOfBirth: DateTime(1992, 11, 23),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Хана засвар',
    category: 'Засвар',
    password: 'skin12567',
    salary: 53000,
    url:
        'https://i.pinimg.com/originals/70/ab/c9/70abc9170ec6c5b82d83b1b467290f53.jpg',
    uploadedAt: DateTime(1992, 11, 23),
  ),
  Employee1(
    review: 180,
    rating: 4.1,
    fullName: 'Болдоо',
    email: 'bold1@gmail.com',
    phoneNumber: '90122312',
    address: 'Чингэлтэй дүүрэг',
    dateOfBirth: DateTime(1983, 04, 01),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Сантехникийн үйлчилгээ',
    category: 'Сантехник',
    password: 'q198457',
    salary: 53000,
    url:
        'https://www.whistler-jobs.com/wp-content/uploads/2019/06/Housekeeper-Cleaner-Male.jpg',
    uploadedAt: DateTime(1983, 04, 01),
  ),
  Employee1(
    review: 174,
    rating: 3.6,
    fullName: 'Энхмаа',
    email: 'maaenkh5@gmail.com',
    phoneNumber: '98995436',
    address: 'Хороолол',
    dateOfBirth: DateTime(1991, 12, 27),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Бүх биеийн бариа',
    category: 'Массаж',
    password: '123456',
    salary: 56000,
    url:
        'https://moussyusa.com/wp-content/uploads/2019/01/Housekeeper-Manager-Job-Description.jpg',
    uploadedAt: DateTime(1991, 12, 27),
  ),
  Employee1(
    review: 112,
    rating: 2.9,
    fullName: 'Мөнх-Эрдэнэ',
    email: 'munhuuerdnea@gmail.com',
    phoneNumber: '97321244',
    address: 'Хүүхдийн 100',
    dateOfBirth: DateTime(1996, 09, 30),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Гал тогооны хэрэгсэл',
    category: 'Цахилгаан хэрэгсэл',
    password: 'munku4321',
    salary: 38000,
    url:
        'https://image.freepik.com/free-photo/male-housekeeper-cleaning-glass-window-home_58466-11238.jpg',
    uploadedAt: DateTime(1996, 09, 30),
  ),
  Employee1(
    review: 128,
    rating: 3.7,
    fullName: 'Дуламсүрэн',
    email: 'dulmaa20@gmail.com',
    phoneNumber: '91114567',
    address: 'Цамбагарав',
    dateOfBirth: DateTime(1984, 09, 24),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Тааз цэвэрлэгээ',
    category: 'Цэвэрлэгээ',
    password: 'ц534678',
    salary: 52000,
    url:
        'https://www.householdstaff.agency/uploads/9/9/9/5/9995793/head-housekeeper-jons_orig.png',
    uploadedAt: DateTime(1984, 09, 24),
  ),
  Employee1(
    review: 145,
    rating: 4.3,
    fullName: 'Амгаланбаатар',
    email: 'Amgaamga@gmail.com',
    phoneNumber: '96437648',
    address: 'ТБД Андууд',
    dateOfBirth: DateTime(2000, 11, 26),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Халуун, хүйтэн ус холболт',
    category: 'Сантехник',
    password: '2188684',
    salary: 58000,
    url:
        'https://1.bp.blogspot.com/_ejUhU6mxGtM/TQO7EwxRtKI/AAAAAAAAAEU/bSCAWP09cG4/s1600/Male+Housekeeper.jpg',
    uploadedAt: DateTime(2000, 11, 26),
  ),
  Employee1(
    review: 145,
    rating: 4.6,
    fullName: 'Нандин',
    email: 'nandiab0903@gmail.com',
    phoneNumber: '95256017',
    address: 'Яармаг',
    dateOfBirth: DateTime(1985, 09, 03),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Зурагт засвар',
    category: 'Цахилгаан хэрэгсэл',
    password: '98768',
    salary: 57500,
    url:
        'https://homemaidbetter.com/wp-content/uploads/2019/04/shutterstock_526418566.jpg',
    uploadedAt: DateTime(1985, 09, 03),
  ),
  Employee1(
    review: 119,
    rating: 3.2,
    fullName: 'Галаа',
    email: 'galaabn1@gmail.com',
    phoneNumber: '85158558',
    address: 'Нисэх',
    dateOfBirth: DateTime(1993, 03, 18),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Нэмэлт залгуур гаргах',
    category: 'Цахилгаан хэрэгсэл',
    password: '123456',
    salary: 46000,
    url:
        'https://i.pinimg.com/originals/78/21/6e/78216eb659f60d3f5370663c095891e0.jpg',
    uploadedAt: DateTime(1993, 03, 18),
  ),
  Employee1(
    review: 125,
    rating: 3.8,
    fullName: 'Баярмаа',
    email: 'bayrrmaa6@gmail.com',
    phoneNumber: '90157890',
    address: 'Бөхийн өргөө',
    dateOfBirth: DateTime(1989, 06, 21),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Угаалгын үйлчилгээ',
    category: 'Угаалга',
    password: 'key4563',
    salary: 53000,
    url:
        'https://www.mbfhouseholdstaffing.com/wp-content/uploads/2012/08/iStock_000009203712Small.jpg',
    uploadedAt: DateTime(1989, 06, 21),
  ),
  Employee1(
    review: 135,
    rating: 4.4,
    fullName: 'Мөнхжин',
    email: 'mujinuka@gmail.com',
    phoneNumber: '80353675',
    address: 'Хархорин',
    dateOfBirth: DateTime(1999, 07, 11),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Машин засвар',
    category: 'Засвар',
    password: 'muuju234',
    salary: 60000,
    url:
        'https://sep.yimg.com/ay/yhst-5698391348794/men-s-spun-polyester-service-shirt-31.png',
    uploadedAt: DateTime(1999, 07, 11),
  ),
  Employee1(
    review: 145,
    rating: 5.3,
    fullName: 'Бээри',
    email: 'beery.be05@gmail.com',
    phoneNumber: '99479767',
    address: 'Их Тэнгэр',
    dateOfBirth: DateTime(2001, 04, 19),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Тавилга зөөх',
    category: 'Засвар',
    password: 'azbeery1208',
    salary: 65000,
    url:
        'https://sc01.alicdn.com/kf/Haf42919f90514308a3b9b1b6af1233edk/200363391/Haf42919f90514308a3b9b1b6af1233edk.jpg',
    uploadedAt: DateTime(2001, 04, 19),
  ),
  Employee1(
    review: 148,
    rating: 5.6,
    fullName: 'Ану-Дөл',
    email: 'anudolmi@gmail.com',
    phoneNumber: '98243456',
    address: 'Содон хороолол',
    dateOfBirth: DateTime(1885, 08, 24),
    description:
        'Lorem ipsum is a dummy text without any sense. It is a sequence of Latin words that, as they are positioned, do not form sentences with a complete sense, but give life to a test text useful to fill spaces that will subsequently be occupied from ad hoc texts composed by communication professionals.',
    categorytext: 'Хивс цэвэрлэгээ',
    category: 'Цэвэрлэгээ',
    password: 'massa1234',
    salary: 63000,
    url:
        'https://4.imimg.com/data4/VI/RP/MY-7627491/housekeeping-apron-500x500.jpeg',
    uploadedAt: DateTime(1985, 08, 24),
  ),
  Employee1(
    rating: 3.9,
    review: 42,
    fullName: 'Carol Williams',
    email: 'carol.williams@example.com',
    phoneNumber: '+12345678903',
    address: '789 Pine Lane',
    dateOfBirth: DateTime(1992, 3, 3),
    description: 'Product Manager',
    categorytext: 'Оффисын хана будах',
    salary: 50000,
    category: 'Будаг',
    password: '123456',
    url: 'https://example.com/photo-carol.jpg',
    uploadedAt: DateTime(1990, 1, 1),
  ),
  Employee1(
    rating: 3.9,
    review: 42,
    fullName: 'Carol Williams',
    email: 'carol.williams@example.com',
    phoneNumber: '+12345678903',
    address: '789 Pine Lane',
    dateOfBirth: DateTime(1992, 3, 3),
    description: 'Product Manager',
    categorytext: 'Хана будах',
    salary: 50000,
    category: 'Будаг',
    password: '123456',
    url: 'https://example.com/photo-carol.jpg',
    uploadedAt: DateTime(1990, 1, 1),
  ),
];

List<ServiceItemCard> serviceListItems = [
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xff7210ff), icon: Icons.favorite, name: 'Цэвэрлэгээ'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xffEA10AC), icon: Icons.favorite, name: 'Засвар'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xffFFCD29), icon: Icons.favorite, name: 'Угаалга'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xffF54336),
        icon: Icons.favorite,
        name: 'Цахилгаан хэрэгсэл'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xff4AAF57), icon: Icons.favorite, name: 'Сантехник'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xff9953FF), icon: Icons.favorite, name: 'Гоо сайхан'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xffCC0100), icon: Icons.favorite, name: 'Массаж'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xffCC0100), icon: Icons.favorite, name: 'Будах'),
  ),
];

// List<BookingItemCard> bookingList = [
//   BookingItemCard(
//     bookingitems: Booking(
//         employee: Employee(
//           name: 'Анужин',
//           category: 'Цэвэрлэгээ',
//           employeeId: 0,
//           img: 'assets/images/profile.webp',
//           rating: 4.8,
//           review: 841,
//           salary: 25,
//           favorite: true,
//         ),
//         bookingId: 0,
//         status: 0),
//   ),
//   BookingItemCard(
//     bookingitems: Booking(
//         employee: Employee(
//           name: 'Сараа',
//           category: 'Цэвэрлэгээ',
//           employeeId: 0,
//           img: 'assets/images/profile.webp',
//           rating: 4.8,
//           review: 841,
//           salary: 25,
//           favorite: false,
//         ),
//         bookingId: 0,
//         status: 0),
//   ),
//   BookingItemCard(
//     bookingitems: Booking(
//         employee: Employee(
//           name: 'Заяа',
//           category: 'Цэвэрлэгээ',
//           employeeId: 0,
//           img: 'assets/images/profile.webp',
//           rating: 4.8,
//           review: 841,
//           salary: 25,
//           favorite: true,
//         ),
//         bookingId: 0,
//         status: 1),
//   ),
//   BookingItemCard(
//     bookingitems: Booking(
//         employee: Employee(
//           name: 'Бямбаа',
//           category: 'Цэвэрлэгээ',
//           employeeId: 0,
//           img: 'assets/images/profile.webp',
//           rating: 4.8,
//           review: 841,
//           salary: 25,
//           favorite: false,
//         ),
//         bookingId: 0,
//         status: 2),
//   ),
//   BookingItemCard(
//     bookingitems: Booking(
//         employee: Employee(
//           name: 'Ариука',
//           category: 'Цэвэрлэгээ',
//           employeeId: 0,
//           img: 'assets/images/profile.webp',
//           rating: 4.8,
//           review: 841,
//           salary: 25,
//           favorite: false,
//         ),
//         bookingId: 0,
//         status: 2),
//   ),
//   BookingItemCard(
//     bookingitems: Booking(
//         employee: Employee(
//           name: 'Ари',
//           category: 'Цэвэрлэгээ',
//           employeeId: 0,
//           img: 'assets/images/profile.webp',
//           rating: 4.8,
//           review: 841,
//           salary: 25,
//           favorite: true,
//         ),
//         bookingId: 0,
//         status: 1),
//   ),
//   BookingItemCard(
//     bookingitems: Booking(
//         employee: Employee(
//           name: 'Амараа',
//           category: 'Цэвэрлэгээ',
//           employeeId: 0,
//           img: 'assets/images/profile.webp',
//           rating: 4.8,
//           review: 841,
//           salary: 25,
//           favorite: true,
//         ),
//         bookingId: 0,
//         status: 0),
//   ),
//   BookingItemCard(
//     bookingitems: Booking(
//         employee: Employee(
//           name: 'Эрдэнэ',
//           category: 'Цэвэрлэгээ',
//           employeeId: 0,
//           img: 'assets/images/profile.webp',
//           rating: 4.8,
//           review: 841,
//           salary: 25,
//           favorite: false,
//         ),
//         bookingId: 0,
//         status: 0),
//   )
// ];

// final List<String> _categories = ['All', 'Cleaning', 'Repairing', 'Painting'];

// final List<String> _bookingStatus = ['Upcoming', 'Completed', 'Selected'];
