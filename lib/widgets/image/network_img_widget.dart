import 'package:flutter/material.dart';

class NetworkImgWidget extends StatefulWidget {
  final imgUrl;
  final placeHolderAsset;

  NetworkImgWidget({Key key, this.placeHolderAsset, this.imgUrl})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NetworkImgWidgetState(placeHolderAsset, imgUrl);
  }
}

class _NetworkImgWidgetState extends State<NetworkImgWidget> {
  final imgUrl;
  final placeHolderAsset;
  Image img, netImg;
  _NetworkImgWidgetState(this.placeHolderAsset, this.imgUrl);

  @override
  void initState() {
    super.initState();
    img = Image.asset(placeHolderAsset);
    try{
      netImg = Image.network(imgUrl);
    }on Exception catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      img,
      netImg
    ],);
  }

}
