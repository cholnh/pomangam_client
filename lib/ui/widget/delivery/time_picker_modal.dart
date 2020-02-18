import 'package:flutter/material.dart';
import 'package:pomangam_client/common/constants/pomangam_theme.dart';
import 'package:pomangam_client/common/i18n/i18n.dart';

class TimePickerModal extends StatelessWidget {

  final int time;
  final Function onSelected;

  TimePickerModal({this.time, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Opacity(
                        opacity: 0.0,
                        child: const IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: null,
                        )
                    ),
                    Flexible(
                      child: Text(
                          '${Messages.timePickerTitle}',
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                    ),
                    IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: (){
                          Navigator.of(context).pop();
                        }
                    ),
                  ]
              ),
              const Divider(height: 0.1),
              ListTile(
                title: time != 12
                    ? const Center(child: Text('12시 도착'))
                    : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('12시 도착'),
                        const Padding(padding: EdgeInsets.all(3)),
                        const Icon(Icons.check, color: primaryColor)
                      ],
                    )
                ),
                onTap: () => onSelected(12),
              ),
              const Divider(height: 0.1),
              ListTile(
                title: time != 13
                    ? const Center(child: Text('13시 도착'))
                    : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('13시 도착'),
                        const Padding(padding: EdgeInsets.all(3)),
                        const Icon(Icons.check, color: primaryColor)
                      ],
                    )
                ),
                onTap: () => onSelected(13),
              ),
              const Divider(height: 0.1),
              ListTile(
                title: time != 17
                    ? const Center(child: Text('17시 도착'))
                    : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('17시 도착'),
                        const Padding(padding: EdgeInsets.all(3)),
                        const Icon(Icons.check, color: primaryColor)
                      ],
                    )
                ),
                onTap: () => onSelected(17),
              ),
              const Divider(height: 0.1),
              ListTile(
                title: time != 18
                    ? const Center(child: Text('18시 도착'))
                    : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('18시 도착'),
                        const Padding(padding: EdgeInsets.all(3)),
                        const Icon(Icons.check, color: primaryColor)
                      ],
                    )
                ),
                onTap: () => onSelected(18),
              ),
              const Divider(height: 0.1),
            ],
          )
        ],
      ),
    );
  }
}
