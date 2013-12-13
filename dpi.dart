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

  query("#img_path").onChange.listen((e) {
    var files = query("#img_path").files;
    if (files.length == 1) {
      final img = files[0];
      final reader = new FileReader();
      reader.addEventListener("load", (e) {
        query("#funky_img").src = reader.result;
        query("#funky_img_small").src = reader.result;
      });
      reader.readAsDataUrl(img);
    }
  });
}

calc(e) {
  var pxWidth = int.parse(query("#funky_img").naturalWidth.toString());
  var pxHeight = int.parse(query("#funky_img").naturalHeight.toString());
  var mmWidth = int.parse(query("#mm_width").value.toString());
  var mmHeight = mmWidth/pxWidth*pxHeight;
  var tmp_quality = "try_again";

  tmp_quality = check_quality(pxWidth, pxHeight, mmWidth, mmHeight, 300);
  query("#img_quality_result").classes = [tmp_quality["class"]];
  query("#img_quality_result p").text = tmp_quality["text"];

  query("#px_width").text = pxWidth.toString() + "px";
  query("#px_height").text = pxHeight.toString() + "px";
  
}

check_quality(pxWidth, pxHeight, mmWidth, mmHeight, dpi) {
  var oneInchInMm = 25.4;
  var quality = {"class": "try_again", "text": "schlecht"};
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
    quality = {"class": "well_done", "text": "gut"};
  } else if (ptPxRatioWidth > 0.5 && ptPxRatioHeight > 0.5) {
    quality = {"class": "not_bad", "text": "geht so"};
  }

  return quality;

}
