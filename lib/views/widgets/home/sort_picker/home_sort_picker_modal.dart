import 'package:flutter/material.dart';
import 'package:pomangam_client/_bases/constants/pomangam_theme.dart';
import 'package:pomangam_client/_bases/i18n/i18n.dart';

class HomeSortPickerModal extends StatelessWidget {

  final int sort;
  final Function onSelected;

  HomeSortPickerModal({this.sort, this.onSelected});

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
                          '${Messages.sortPickerTitle}',
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
              const Divider(height: 0.1, color: Colors.black),
              ListTile(
                title: sort != 0
                ? const Center(child: Text('추천순'))
                : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('추천순'),
                        const Padding(padding: EdgeInsets.all(3)),
                        const Icon(Icons.check, color: primaryColor)
                      ],
                    )
                ),
                onTap: () => onSelected(0),
              ),
              const Divider(height: 0.1),
              ListTile(
                title: sort != 1
                ? const Center(child: Text('주문많은순'))
                : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('주문많은순'),
                        const Padding(padding: EdgeInsets.all(3)),
                        const Icon(Icons.check, color: primaryColor)
                      ],
                    )
                ),
                onTap: () => onSelected(1),
              ),
              const Divider(height: 0.1),
              ListTile(
                title: sort != 2
                ? const Center(child: Text('별점높은순'))
                : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('별점높은순'),
                        const Padding(padding: EdgeInsets.all(3)),
                        const Icon(Icons.check, color: primaryColor)
                      ],
                    )
                ),
                onTap: () => onSelected(2),
              ),
              const Divider(height: 0.1),
              ListTile(
                title: sort != 3
                ? const Center(child: Text('리뷰많은순'))
                : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('리뷰많은순'),
                        const Padding(padding: EdgeInsets.all(3)),
                        const Icon(Icons.check, color: primaryColor)
                      ],
                    )
                ),
                onTap: () => onSelected(3),
              ),
              const Divider(height: 0.1),
            ],
          )
        ],
      ),
    );
  }
}
