import 'package:flutter/material.dart';

class GlobalErrorWidget extends StatelessWidget {
  final void Function() onRefresh;
  final String errorMsg;

  const GlobalErrorWidget({
    Key key,
    this.onRefresh,
    this.errorMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: InkWell(
          onTap: onRefresh,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.refresh, size: 36, color: Colors.black54),
                SizedBox(
                  height: 12,
                ),
                Text('Hata!',
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54)),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Bir hata oluştu, lütfen daha sonra tekrar deneyin.',
                  textScaleFactor: 1,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45),
                ),
                SizedBox(
                  height: 8,
                ),
                errorMsg != null && errorMsg != ''
                    ? Text(
                        '${errorMsg.toUpperCase()}',
                        style: TextStyle(fontSize: 10, color: Colors.black26),
                        textScaleFactor: 1,
                        maxLines: 5,
                        textAlign: TextAlign.center,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
