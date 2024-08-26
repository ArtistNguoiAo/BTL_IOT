import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/media_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyleUtils.textStyleNunitoS24W700White,
          ),
          toolbarHeight: 65,
          backgroundColor: ColorUtils.primaryColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              FontAwesomeIcons.chevronLeft,
              color: ColorUtils.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _avatar(),
                _spaceHeight(16),
                _item(context, 'Lê Quốc Trung', FontAwesomeIcons.userLarge),
                _spaceHeight(16),
                _item(context, 'B21DCCN730', FontAwesomeIcons.addressCard),
                _spaceHeight(16),
                _item(context, 'lequoctrung.dev.2k3@gmail.com', FontAwesomeIcons.at),
                _spaceHeight(16),
                _item(context, '0333 982 632', FontAwesomeIcons.phone),
                _spaceHeight(16),
                _item(context, 'ArtistNguoiAo', FontAwesomeIcons.github),
                _spaceHeight(16),
                _item(context, 'Trung', FontAwesomeIcons.facebook),
                _spaceHeight(16),
                _itemPremium(),
                _spaceHeight(16),
                _buttonAdd(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatar(){
    return CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage(MediaUtils.imgAvatar),
    );
  }

  Widget _item(BuildContext context, String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorUtils.primaryColor
        ),
      ),
      child: Row(
        children: [
          FaIcon(
            icon,
            color: ColorUtils.primaryColor,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyleUtils.textStyleNunitoS20W700Black,
          ),
        ],
      ),
    );
  }

  Widget _itemPremium() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: ColorUtils.yellowGold,
        ),
      ),
      child: Row(
        children: [
          FaIcon(
            FontAwesomeIcons.crown,
            color: ColorUtils.yellowGold,
          ),
          const SizedBox(width: 16),
          Text(
            'Premium',
            style: TextStyleUtils.textStyleNunitoS20W700Black,
          ),
        ],
      ),
    );
  }

  Widget _spaceHeight(double height) {
    return SizedBox(height: height);
  }

  Widget _buttonAdd() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorUtils.primaryColor,
        ),
        color: ColorUtils.primaryColor,
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.plus,
              color: ColorUtils.white,
            ),

          ],
        ),
      ),
    );
  }
}
