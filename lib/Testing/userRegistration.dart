// // import 'package:maps_toolkit/maps_toolkit.dart' as mp;
// // import 'package:dart_geohash/dart_geohash.dart';
// // // var name = 'Ayushman Joshi';
// // // var phone = 9119031812;
// // // var email = "ayushman1208@gmail.com";
// // // var gender = "male";
// // // var uni = 2002182;
// //
// // // Future<void> main() async {
// // //   print("Connecting to mysql server...");
// // //
// // //   // create connection
// // //   final conn = await MySQLConnection.createConnection(
// // //     host: 'db-mysql-nyc1-49352-do-user-13193164-0.b.db.ondigitalocean.com',
// // //   port: 25060,
// // //   userName: 'doadmin',
// // //   password: 'AVNS_ORaHJ-uaqGm8Uk4774w',
// // //   databaseName: 'defaultdb',
// // //   );
// // //
// // //   await conn.connect();
// // //
// // // var res = await conn.execute('select * from mainTable');
// // // print(res.forEach((element) {
// // //   elem
// // // }));
// // // //await conn.execute('Create Table mainTable(phone numeric(10) not null primary key, name varchar(255) not null, email varchar(255) not null, gender varchar(7),univ int)');
// // // //  var val = await conn.execute( "select * from mainTable where gender = :gender",
// // // //     {
// // // //
// // // //
// // // //
// // // //       "gender":gender,
// // // //
// // // //     },);
// // // //  for ( var i in val.rows)
// // // //    {
// // // //      print (i.assoc());
// // // //    }
// // //   await conn.execute('update mainTable set image=\'https://imagebr.nyc3.cdn.digitaloceanspaces.com/scaled_bd07c301-36f4-41c9-8941-cf2822a9aa282387746175689190425.jpg\' where phone = 7452976914');
// // //    print('object');
// // // }
// // // //
// // // // import 'package:mysql1/mysql1.dart';
// // // //
// // // // var settings = ConnectionSettings(
// // // //   host: 'db-mysql-nyc1-49352-do-user-13193164-0.b.db.ondigitalocean.com',
// // // //   port: 25060,
// // // //   user: 'doadmin',
// // // //   password: 'AVNS_ORaHJ-uaqGm8Uk4774w',
// // // //   db: 'defaultdb',
// // // // );
// // // // // var name = 'Upendra Pandit';
// // // // // var phone = 7452976914;
// // // // // var email = "kumar109upendra@gmail.com";
// // // // // var gender = "male";
// // // // // var uni = 2017105;
// // // //
// // // // Future main() async {
// // // //   var conn = await MySqlConnection.connect(settings);
// // // //
// // // //   print('object');
// // // //  // await conn.query( 'CREATE TABLE usersd (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(255), email varchar(255), age int)');
// // // //   await conn.query('insert into usersd (id, name, email, age) values (?, ?, ?, ?)', [1,'Bob', 'b@b.c', 0]);
// // // //   print('object');
// // // //   await conn.close();
// // // // }
// // void main() {
// //  //  var geoHasher = GeoHasher();
// //  // String val;
// //  //  // Given a longitude and latitude
// //  //  // Encoding Example
// //  //  print(geoHasher.encode(78.049661,30.287869 ));
// //  //  // Including a specific precision
// //  //  print(val=geoHasher.encode(78.049661,30.287869, precision: 7));
// //  //  // Default precision is 12 characters
// //  //  print(geoHasher.encode(78.049661,30.287869, precision: 10));
// //  //  print(geoHasher.encode(78.049661,30.287869));
// //  //  // Specific precision that is overly precise will produce arbitrary false accuracy
// //  //
// //  //
// //  //  // Decode takes a geohash and returns a List[2] with longitude and latitude
// //  //  // The results are not automatically adjusted to the accuracy (length) of the
// //  //  // given geocode. You will need to decide what degree of accuracy is required
// //  //   val="ttrm3ef";r
// //  //  print(geoHasher.decode(val)[0]);
// //  //  print('printed');
// //  //  // Both of these will give the same geohash as shown above accuracy at
// //  //  // "human/tree" level. So be careful when determining accuracy
// //  //  print(geoHasher.encode(78.049661,30.287869, precision: 7));
// //  //  print(geoHasher.encode(78.049661,30.287869, precision: 7));
// //  // print('encoded');
// //  //  // Neighbors will return the central geohash (the given one) along with the
// //  //  // 8 surrounding squares as a map with given directions
// //  //  // This will return the other geohash at all the same level of accuracy as the
// //  //  // one given
// //  //  print(geoHasher.neighbors(val));
// //  //
// //  //  /* longitude and latitude are roughly
// //  //  decimal   places 	    rough scale
// //  //  0         1.0         country
// //  //  1 	      0.1         large city
// //  //  2 	      0.01        town or village
// //  //  3 	      0.001       neighborhood
// //  //  4 	      0.0001      individual street
// //  //  5 	      0.00001     individual trees
// //  //  6 	      0.000001 	  individual humans
// //  //  */
// //  //
// //  //  /* Geohash Scale
// //  //  Geohash length 	Cell width 	Cell height
// //  //  1 	              multiple countries
// //  //  2 	              state - multiple states
// //  //  3 	              multiple cities
// //  //  4 	              average city
// //  //  5 	              small town
// //  //  6 	              neighborhood
// //  //  7 	              individual street
// //  //  8 	              small store
// //  //  9 	              individual trees
// //  //  10 	              individual humans
// //  //  .....
// //  //  */
// //  //
// //  // print('I am here');
// //  //  var myHash = GeoHash(val);
// //  //  print(myHash.geohash);
// //  //  print(myHash.longitude());
// //  //  print(myHash.longitude(decimalAccuracy: 12));
// //  //  print(myHash.latitude());
// //  //  print(myHash.latitude(decimalAccuracy: 6));
// //  //   print('Now i will print neighbours');
// //  //  print(myHash.neighbors);
// //  //  print(myHash.neighbor(Direction.NORTH));
// //  // print('I am at other hash');
// //  //  var myOtherHash = GeoHash.fromDecimalDegrees(78.049661,30.287869);
// //  //  print(myOtherHash.geohash);
// //  //  print(myOtherHash.longitude());
// //  //  print(myOtherHash.longitude(decimalAccuracy: 4));
// //  //  print(myOtherHash.latitude());
// //  //  print(myOtherHash.latitude(decimalAccuracy: 4));
// //  //  print(myOtherHash.neighbors);
// //  //  print(myOtherHash.neighbor(Direction.NORTH));
// //
// // }
// // import 'package:path/path.dart';
// // import 'package:socket_io_client/socket_io_client.dart'as IO;
//
// // import 'package:web_socket_channel/web_socket_channel.dart';
// //
// // void main() {
// //   final _channel =
// //       WebSocketChannel.connect(Uri.parse('ws://localhost:3001/pass'));
// //
// //   _channel.stream.asBroadcastStream(onListen: (val) {
// //     print(val);
// //   });
// //   for (int i = 0; i < 10; i++) _channel.sink.add('Hello a haa ab');
// // }
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// var channel;
// void initailizeWebsocket() async {
// channel = WebSocketChannel.connect(Uri.parse('ws://139.59.84.205:3005?phone=7452976914'));
//    channel.sink.add("hello frm flutter");
//   channel.stream.listen((event) {
//     print(event);
//     print(event.runtimeType);
//   });
//   print("exitted websocekt method ");
// }
//
//
void calldata(var a, var b)async{

  var response = await http.get(Uri.parse('http://167.71.238.162/users/updateToken?phone=$a&token=NULL'));
}
void main() {
  calldata(7452976914,null);
 getData();
  print("Is the problem not here??");

 // channel.sink.add('2yo');
 // channel.sink.add('3yo');
 // channel.sink.add('4yo');
}
void getData() async {
  print("Is the problem here??");
  print("Is the problem not here??");

}
