import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/key/pmg_key.dart';
import 'package:pomangam_client/_bases/util/string_utils.dart';
import 'package:pomangam_client/providers/store/store_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreDescriptionWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.storeDescription,
      child: Container(
        padding: EdgeInsets.only(left: 15.0, bottom: 20.0, right: 15.0),
        alignment: Alignment.centerLeft,
        child: Consumer<StoreModel>(
          builder: (_, model, child) {
            bool isStoreDescriptionOpened = model.isStoreDescriptionOpened;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${model.store?.storeInfo?.name ?? ''}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: titleFontSize)),
                Padding(padding: EdgeInsets.only(top: 3.0)),
                Text('${model.store?.storeCategory ?? ''}', style: TextStyle(color: Colors.black45, fontSize: subTitleFontSize)),
                Text('${model.store?.storeInfo?.description ?? ''}',
                    maxLines: isStoreDescriptionOpened ? 20 : 5,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(fontSize: subTitleFontSize)
                ),
                model.store?.storeInfo?.subDescription != null
                  ? Text('${model.store?.storeInfo?.subDescription ?? ''}',
                      maxLines: isStoreDescriptionOpened ? 20 : 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(fontSize: subTitleFontSize)
                    )
                  : Container(),
                isStoreDescriptionOpened
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 20.0)),

                      // 영업정보
                      Text('영업 정보', style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize)),
                      Padding(padding: EdgeInsets.only(top: 3.0)),
                      GestureDetector(
                        onTap: model.store?.storeInfo?.companyPhoneNumber != null
                          ? () => _launch('${model.store?.storeInfo?.companyPhoneNumber}')
                          : () {},
                        child: Row(
                          children: <Widget>[
                            Text('전화번호 : ${model.store?.storeInfo?.companyPhoneNumber ?? '미등록'}', style: TextStyle(fontSize: subTitleFontSize)),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            model.store?.storeInfo?.companyPhoneNumber != null
                                ? Text('전화하기', style: TextStyle(color: primaryColor, fontSize: 11.0))
                                : Container()
                          ],
                        ),
                      ),
                      Text(
                          '운영시간 : ${_timeFormat(model.store?.storeSchedule?.openTime) ?? ''} ~ ${_timeFormat(model.store?.storeSchedule?.closeTime) ?? ''}',
                          style: TextStyle(fontSize: subTitleFontSize)
                      ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),

                      // 사업자 정보
                      Text('사업자 정보', style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize)),
                      Padding(padding: EdgeInsets.only(top: 3.0)),
                      Text('대표자명 : ${model.store?.storeInfo?.ownerName ?? '미등록'}', style: TextStyle(fontSize: subTitleFontSize)),
                      Text('상호명 : ${model.store?.storeInfo?.companyName ?? '미등록'}', style: TextStyle(fontSize: subTitleFontSize)),
                      Text('위치 : ${model.store?.storeInfo?.companyLocation ?? '미등록'}', style: TextStyle(fontSize: subTitleFontSize)),
                    ],
                  )
                : Container()
              ],
            );
          }
        ),
      )
    );
  }

  String _timeFormat(String time) {
    if(time == null) return null;
    var times = time.split(':');
    return '${times[0]}:${times[1]}';
  }

  void _launch(String tel) async {
    tel = StringUtils.onlyNumber(tel);
    var url = 'tel://$tel';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}