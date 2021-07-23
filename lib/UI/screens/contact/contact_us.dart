import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: context.screenWidth, maxHeight: context.screenHeight),
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !(context.mdWindowSize == MobileWindowSize.xlarge ||
                            context.mdWindowSize == MobileWindowSize.large ||
                            context.mdWindowSize == MobileWindowSize.medium)
                        ? IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 24,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                        : Container(),
                    SizedBox(
                      width: 24,
                    ),
                    Container(
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !(context.mdWindowSize == MobileWindowSize.xlarge ||
                            context.mdWindowSize == MobileWindowSize.large ||
                            context.mdWindowSize == MobileWindowSize.medium)
                        ? Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 0, top: 80),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    contactUsItem(
                                        Icons.mail,
                                        'General Enquiries - Enquiry@dharamik.com',
                                        'https://mail.google.com/mail/u/0/?fs=1&tf=cm&source=mailto&to=geoff@enquiry@dharamik.com'),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    contactUsItem(
                                        Icons.outgoing_mail,
                                        'Member support - support@dharamik.com',
                                        'https://mail.google.com/mail/u/0/?fs=1&tf=cm&source=mailto&to=geoff@support@dharamik.com'),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    contactUsItem(
                                        FontAwesomeIcons.phone,
                                        'Phone - +91 7278777471',
                                        'tel:+91 7278777471'),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    contactUsItem(
                                        FontAwesomeIcons.whatsapp,
                                        'Whatsapp - +91 7278777471                               ',
                                        'https://api.whatsapp.com/send?phone=+91 7278777471=hello'),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    contactUsItem(
                                        FontAwesomeIcons.map,
                                        'Headquarters - Ahemdabad, Gujrat, India',
                                        'https://www.google.com/maps/place/Ahmedabad,+Gujarat,+India/@23.0201818,72.4396571,11z/data=!3m1!4b1!4m5!3m4!1s0x395e848aba5bd449:0x4fcedd11614f6516!8m2!3d23.022505!4d72.5713621'),
                                  ],
                                )),
                          )
                        : Container(
                            padding: EdgeInsets.only(left: 0, top: 80),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                contactUsItem(
                                    Icons.mail,
                                    'General Enquiries - Enquiry@dharamik.com',
                                    'https://mail.google.com/mail/u/0/?fs=1&tf=cm&source=mailto&to=geoff@enquiry@dharamik.com'),
                                SizedBox(
                                  height: 40,
                                ),
                                contactUsItem(
                                    Icons.outgoing_mail,
                                    'Member support - support@dharamik.com',
                                    'https://mail.google.com/mail/u/0/?fs=1&tf=cm&source=mailto&to=geoff@support@dharamik.com'),
                                SizedBox(
                                  height: 40,
                                ),
                                contactUsItem(
                                    FontAwesomeIcons.phone,
                                    'Phone - +91 7278777471',
                                    'tel:+91 7278777471'),
                                SizedBox(
                                  height: 40,
                                ),
                                contactUsItem(
                                    FontAwesomeIcons.whatsapp,
                                    'Whatsapp - +91 7278777471                               ',
                                    'https://api.whatsapp.com/send?phone=+91 7278777471=hello'),
                                SizedBox(
                                  height: 40,
                                ),
                                contactUsItem(
                                    FontAwesomeIcons.map,
                                    'Headquarters - Ahemdabad, Gujrat, India',
                                    'https://www.google.com/maps/place/Ahmedabad,+Gujarat,+India/@23.0201818,72.4396571,11z/data=!3m1!4b1!4m5!3m4!1s0x395e848aba5bd449:0x4fcedd11614f6516!8m2!3d23.022505!4d72.5713621'),
                              ],
                            )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String url(phone) {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=hello}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=hello}"; // new line
    }
  }

  contactUsItem(IconData icon, String text, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.red,
          ),
          SizedBox(
            width: 30,
          ),
          !(context.mdWindowSize == MobileWindowSize.xlarge ||
                  context.mdWindowSize == MobileWindowSize.large ||
                  context.mdWindowSize == MobileWindowSize.medium)
              ? Expanded(
                  child: InkWell(
                    child: Text(
                      text,
                      // overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onTap: () async {
                      await canLaunch(url)
                          ? await launch(url)
                          : throw 'Could not launch $url';
                    },
                  ),
                )
              : InkWell(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    await canLaunch(url)
                        ? await launch(url)
                        : throw 'Could not launch $url';
                  },
                )
        ],
      ),
    );
  }
}
