import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
late List<Widget> imageSliders;

class FullscreenSliderDemo extends StatelessWidget {
  late List<String> imgList;

  FullscreenSliderDemo(this.imgList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

           Container(
             decoration: BoxDecoration(color: Colors.black),
             child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

                InkWell(
                  child: Container( decoration: BoxDecoration(color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 50.0),
                        child: Icon(Icons.arrow_back_ios, color: Colors.white,size: 26,),
                      )
                  ),
                  onTap: (){
                    Navigator.of(context).maybePop();
                  },
                ),
              ]
          ),
           ),

        Expanded(

            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  errorBuilder: (context, exception,stackTrace) {
                  return Image(height: 120,
                    width: 120,
                    image: AssetImage("assets/ErrorImage.png"),);
                },
                  imageProvider: NetworkImage(imgList[index]),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes: PhotoViewHeroAttributes(tag: imgList[index]),
                );
              },
              itemCount: imgList.length,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                  ),
                ),
              ),
//          backgroundDecoration: widget.backgroundDecoration,
//          pageController: widget.pageController,
//          onPageChanged: onPageChanged,
            )
        ),
        ],
      ),
    );
  }
}

