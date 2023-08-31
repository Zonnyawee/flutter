import 'package:flutter/material.dart';
import 'package:flutter_application_11/main.dart';
import 'package:flutter_application_11/models/config.dart';
import 'package:flutter_application_11/models/user.dart';
import 'package:flutter_application_11/screens/login.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String accountName = "N/A";
    String accountEmail = "N/A";
    String accountUrl =
        "https://scontent-sin6-2.xx.fbcdn.net/v/t39.30808-6/274277811_967505610825980_6813770537484437323_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=8bfeb9&_nc_eui2=AeHubyswig9hgHCFsL2SWWLhHbZB_W1rBQAdtkH9bWsFAHfseG3OjZiSTXj6j8WYXyJxC0ZrR67ba_2S2lEZQXvf&_nc_ohc=-wTVHuaA2CAAX-Buyv4&_nc_ht=scontent-sin6-2.xx&oh=00_AfBoyVAtTMNvPJ79LsILKM7uJ8-6Uu2-5awF8meyLD7qOQ&oe=64F20D3D";
    User user = Configure.login;
    if (user.id != null) {
      accountName = user.fullname!;
      accountEmail = user.email!;
    }
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName),
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(accountUrl),
              backgroundColor: Colors.green,
            ),
          ),
          ListTile(
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, Home.routeName);
            },
          ),
          ListTile(
            title: Text("Login"),
            onTap: () {
              Navigator.pushNamed(context, Login.routeName);
            },
          ),
        ],
      ),
    );
  }
}
