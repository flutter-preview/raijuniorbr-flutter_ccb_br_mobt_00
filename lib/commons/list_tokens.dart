import 'package:flutter/material.dart';

class ListTokens extends StatefulWidget {
  const ListTokens({super.key});

  @override
  _ListTokensState createState() => _ListTokensState();
}

class _ListTokensState extends State<ListTokens> {
  List<Person> persons = [];

  @override
  void initState() {
    //adding item to list, you can add using json from network
    persons.add(Person(
        id: "1",
        name: "Hari Prasad Chaudhary",
        phone: "9812122233",
        address: "Kathmandu, Nepal"));
    persons.add(Person(
        id: "2",
        name: "Krishna Karki",
        phone: "9812122244",
        address: "Pokhara, Nepal"));
    persons.add(Person(
        id: "3",
        name: "Ujjwal Joshi",
        phone: "98121224444",
        address: "Bangalore, India"));
    persons.add(Person(
        id: "4",
        name: "Samir Hussain Khan",
        phone: "9812122255",
        address: "Karachi, Pakistan"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add And Delete List"),
          backgroundColor: Colors.redAccent,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: persons.map((personone) {
                return Container(
                  child: Card(
                    child: ListTile(
                      title: Text(personone.name),
                      subtitle:
                          Text("${personone.phone}\n${personone.address}"),
                      trailing: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        child: const Icon(Icons.delete),
                        onPressed: () {
                          //delete action for this button
                          persons.removeWhere((element) {
                            return element.id == personone.id;
                          }); //go through the loop and match content to delete from list
                          setState(() {
                            //refresh UI after deleting element from list
                          });
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }
}

class Person {
  //modal class for Person object
  String id, name, phone, address;
  Person(
      {required this.id,
      required this.name,
      required this.phone,
      required this.address});
}
