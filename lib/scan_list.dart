import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef ItemTapCallback = void Function(
    Map<String, dynamic> item, BuildContext context);

class ScanList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final IconData icon;
  final ItemTapCallback onTap;
  final bool disableLoading;

  const ScanList(
      {Key? key,
      required this.items,
      required this.icon,
      required this.onTap,
      required this.disableLoading})
      : super(key: key);

  Widget _buildItem(
      BuildContext _context, Map<String, dynamic> item, IconData icon,
      {required ItemTapCallback onTap}) {
    return ListTile(
        leading: Container(
          padding: EdgeInsets.all(4.0),
          child: Icon(
            icon,
            color: Colors.blueAccent,
          ),
        ),
        title: Text(
          item['name'] ?? item['ssid'],
          style: TextStyle(color: Theme.of(_context).primaryColorLight),
        ),
        trailing: Text(item['rssi'].toString()),
        onTap: () {
          print('tap');
          onTap(item, _context);
                } //showModel(_context, bleDevice),
        );
  }

  Widget _buildList(BuildContext _context) {
    return Column(
      children: <Widget>[
        this.disableLoading != null && this.disableLoading
            ? Container()
            : SizedBox(
                child: Container(
                    padding: EdgeInsets.all(4.0),
                    height: 80,
                    child: Align(
                        alignment: Alignment.center,
                        child: SpinKitRipple(
                            color: Theme.of(_context).primaryColorLight)))),
        Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildItem(context, items[index], icon, onTap: onTap);
                },
                separatorBuilder: (context, index) => Divider(
                      color: Theme.of(context).dividerColor,
                      height: 1.0,
                    )))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
