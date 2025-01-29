import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/widget/transition_effect.dart';
import '../Waiter/waiter_screen.dart';
import '../chief/chief_screen.dart';

class ChooseJobScreen extends StatefulWidget {
  @override
  _ChooseJobScreenState createState() => _ChooseJobScreenState();
}

class _ChooseJobScreenState extends State<ChooseJobScreen> {
  bool _isChiefLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Choose a Job'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isChiefLoading
                        ? null
                        : () async {
                            setState(() {
                              _isChiefLoading = true;
                            });
                            await Future.delayed(Duration(seconds: 2));

                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                  slideTransition(ChiefScreen()));
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isChiefLoading
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              color: primaryColor,
                              strokeWidth: 3,
                            ),
                          )
                        : Text(
                            'Chief',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: 1),
                          ),
                  ),
                ),
                SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Show loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Prevent closing during loading
                        builder: (context) => Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      );

                      // Wait for 2 seconds
                      await Future.delayed(Duration(seconds: 2));

                      // Close the loading indicator
                      Navigator.pop(context);

                      Navigator.of(context)
                          .pushReplacement(slideTransition(WaiterScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Waiter',
                      style: TextStyle(
                          fontSize: 16, color: Colors.white, letterSpacing: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
