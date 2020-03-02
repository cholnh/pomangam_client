import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';

class StoreDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.storeDescription,
      child: Container(
        padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('맥도날드', style: TextStyle(fontWeight: FontWeight.w600)),
            Text('패스트푸드', style: TextStyle(color: Colors.black45)),
            Text('''
\'정성어린 한 끼 식사를 준비한다\'는 마음가짐 
주문을 받는 즉시 제조 시작.
따듯하고 신선한 높은 퀄리티의 제품 제공!
\'고객을 가장 먼저 생각하는 맘스터치\'입니다.''',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle()),
          ],
        ),
      )
    );
  }
}
