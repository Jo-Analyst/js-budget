import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/loading.dart';

class ContactPhonePage extends StatefulWidget {
  const ContactPhonePage({super.key});

  @override
  State<ContactPhonePage> createState() => _ContactPhonePageState();
}

class _ContactPhonePageState extends State<ContactPhonePage> {
  final searchController = TextEditingController();
  bool isLoading = true,
      selectedEverything = false,
      longPressWasPressed = false;
  String search = '';
  final List<Map<String, dynamic>> _contacts = [];
  List<String> names = [];
  List<String> phones = [];
  List<Map<String, dynamic>> filteredList = [];

  Future<void> _fetchContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      for (int i = 0; i < contacts.toList().length; i++) {
        _contacts.add(
          {
            'name': contacts.toList()[i].displayName,
          },
        );
        final phones = contacts.toList()[i].phones!;
        for (var phone in phones) {
          _contacts[i]['phone'] = phone.value;
        }
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  void importContacts() async {
    // final clientProvider = Provider.of<ClientProvider>(context, listen: false);

    // int index = 0;
    // for (var phone in phones) {
    //   clientProvider
    //       .save({'id': 0, 'name': names[index], 'phone': phone, 'address': ''});
    //   index++;
    // }

    // await Backup.toGenerate();

    // showToast(
    //   message: 'Cliente importado com sucesso.',
    // );
  }

  void selectContact(Map<String, dynamic> contact) {
    setState(() {
      names.contains(contact['name'])
          ? names.remove(contact['name'])
          : names.add(contact['name'] ?? 'Sem nome');

      phones.contains(contact['phone'])
          ? phones.remove(contact['phone'])
          : phones.add(contact['phone'] ?? 'Sem número');
    });
  }

  void clearLists() {
    setState(() {
      names.clear();
      phones.clear();
    });
  }

  selectAll() {
    if (selectedEverything) {
      clearLists();
      setState(() {
        selectedEverything = false;
        longPressWasPressed = false;
      });
      return;
    }

    clearLists();
    setState(() {
      for (var contact in _contacts) {
        names.add(contact['name'] ?? 'Sem nome');
        phones.add(contact['phone'] ?? 'Sem número');
      }

      selectedEverything = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var filteredList = _contacts
        .where((client) =>
            client['name'].toLowerCase().contains(search.toLowerCase()))
        .toList();

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          names.isNotEmpty ? names.length.toString() : 'Importar Contatos',
        ),
        actions: [
          IconButton(
            onPressed: phones.isNotEmpty
                ? () {
                    importContacts();
                  }
                : null,
            icon: Visibility(
              visible: names.isNotEmpty,
              child: IconButton(
                onPressed: () => selectAll(),
                icon: const Icon(
                  Icons.select_all,
                  size: 30,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: phones.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      importContacts();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.check,
                      size: 30,
                    ),
                  )
                : null,
          )
        ],
      ),
      body: isLoading
          ? SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  loading(context, 50),
                  const Text(
                    'Carregando...',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            )
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Buscar contato',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: filteredList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person_search_sharp,
                                size: 100,
                                color:
                                    theme.colorScheme.primary.withOpacity(.7),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Nenhum contato encontrado',
                                style: textStyleSmallDefault,
                              ),
                            ],
                          ),
                        )
                      : ListView(
                          children: filteredList
                              .map((contact) => Column(
                                    children: [
                                      ListTile(
                                        onLongPress: () {
                                          selectContact(contact);
                                          setState(() {
                                            longPressWasPressed =
                                                names.isNotEmpty ? true : false;
                                          });
                                        },
                                        onTap: () {
                                          selectContact(contact);
                                          if (!longPressWasPressed) {
                                            importContacts();
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        selected: longPressWasPressed &&
                                            names.contains(contact["name"]),
                                        selectedTileColor: theme.primaryColor,
                                        selectedColor: Colors.white,
                                        title:
                                            Text(contact["name"] ?? "Sem nome"),
                                        subtitle: Text(
                                          contact["phone"] ?? "Sem número",
                                        ),
                                        leading: CircleAvatar(
                                          maxRadius: 25,
                                          backgroundColor: names
                                                  .contains(contact["name"])
                                              ? Colors.white
                                              : Theme.of(context).primaryColor,
                                          foregroundColor: names
                                                  .contains(contact["name"])
                                              ? Theme.of(context).primaryColor
                                              : Colors.white,
                                          child: Text(
                                            contact["name"]
                                                .toString()
                                                .split("")[0],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ))
                              .toList(),
                        ),
                ),
              ],
            ),
    );
  }
}
