import 'package:test_softap/softap_screen/softap_bloc.dart';
import 'package:test_softap/softap_screen/softap_event.dart';
import 'package:test_softap/softap_screen/softap_state.dart';
import 'package:test_softap/wifi_screen/wifi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SoftApScreen extends StatefulWidget {
  @override
  _SoftApScreenState createState() => _SoftApScreenState();
}

class _SoftApScreenState extends State<SoftApScreen> {

  void _showBottomSheet(BuildContext context) {

    var bottomSheetController = showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight:  Radius.circular(20.0),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.only(top: 5.0),
            height: MediaQuery.of(context).size.height - 50,
            child: WiFiScreenSoftAP(),
          );
        });
    bottomSheetController.whenComplete(() {
      // after prov.
      BlocProvider.of<SoftApBloc>(context).add(SoftApEventStart());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Scanning WiFi devices'),
      ),
      body: BlocProvider(
        create: (BuildContext context) => SoftApBloc(),
        child: BlocBuilder<SoftApBloc, SoftApState>(
          builder: (BuildContext context, SoftApState state) {
            if (state is SoftApStateLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: const Text('Please connect WiFi to ESP32 AP (PROV_XXX) in "Wi-Fi Settings". Once you complete it please tap on "Ready" button.',
                      style: TextStyle(fontSize: 18),),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.width * 0.1,),
                    MaterialButton(
                      color: Colors.lightBlueAccent,
                      elevation: 5,
                      padding: const EdgeInsets.all(15.0),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        'Ready',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),

                      onPressed: () {
                        _showBottomSheet(this.context);
                      },
                    ),
                  ],
                )

              );
            }

            return Center(
              child: SpinKitFoldingCube(color: Theme.of(context).primaryColorDark),
            );
          },
        ),
      ),
    );
  }
}
