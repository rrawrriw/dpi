import "dart:html";

main() {
  query("#calc_baby").onClick.listen((e) { 
      calc(e);
      query("#input_blob").style.display = "none";
      query("#input_info_short").style.display = "block";
      query("#info_blob").style.display = "block";
      query("#legend_blob").style.display = "block";
  });

  query("#input_info_short").onClick.listen((e) {
      query("#input_blob").style.display = "block";
      query("#input_info_short").style.display = "none";
      query("#info_blob").style.display = "none";
      query("#legend_blob").style.display = "none";
  });

  query("#img_path_tmp").onChange.listen((e) {
    var files = query("#img_path_tmp").files;
    if (files.length == 1) {
      final img = files[0];
      final reader = new FileReader();
      reader.addEventListener("load", (e) {
        query("#img_path").value = img.name;
        query("#funky_img").src = reader.result;
        query("#funky_img_small").src = reader.result;
      });
      reader.readAsDataUrl(img);
    }
  });
}

calc(e) {
  var pxWidth = int.parse(query("#funky_img").width.toString());
  var pxHeight = int.parse(query("#funky_img").height.toString());
  var mmWidth = int.parse(query("#mm_width").value.toString());
  var mmHeight = mmWidth/pxWidth*pxHeight;
  var tmp_quality = "try_again";

  tmp_quality = check_quality(pxWidth, pxHeight, mmWidth, mmHeight, 200);
  query("#dpi200").classes = [tmp_quality];
  tmp_quality = check_quality(pxWidth, pxHeight, mmWidth, mmHeight, 300);
  query("#dpi300").classes = [tmp_quality];

  query("#px_width").text = pxWidth.toString() + "px";
  query("#px_height").text = pxHeight.toString() + "px";
  
}

check_quality(pxWidth, pxHeight, mmWidth, mmHeight, dpi) {
  var oneInchInMm = 25.4;
  var quality = "try_again";
  var amountPointsWidth = (mmWidth/oneInchInMm)*dpi; 
  var amountPointsHeight = (mmHeight/oneInchInMm)*dpi; 
  var ptPxRatioWidth = (pxWidth/amountPointsWidth);
  var ptPxRatioHeight = (pxHeight/amountPointsHeight);

  print(dpi.toString() +"dpi --------------");
  print("amount of points (width): "+ amountPointsWidth.toString());
  print("amount of points (height): "+ amountPointsHeight.toString());
  print("points in relation to pixel amount (width): "+ ptPxRatioWidth.toString());
  print("points in relation to pixel amount (height): "+ ptPxRatioHeight.toString());

  if (ptPxRatioWidth > 1 && ptPxRatioHeight > 1) {
    quality = "well_done";
  } else if (ptPxRatioWidth > 0.5 && ptPxRatioHeight > 0.5) {
    quality = "not_bad";
  }

  return quality;

}
