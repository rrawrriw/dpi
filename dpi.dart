import "dart:html";

main() {
  query("#calc_baby").onClick.listen(calc);   
}

calc(e) {
  var oneInchInMm = 25.4;
  var pxWidth = int.parse(query("#px_width").value);
  var pxHeight = int.parse(query("#px_height").value);
  var mmWidth = int.parse(query("#mm_width").value);
  var mmHeight = int.parse(query("#mm_height").value);
  var dpiWidth = int.parse(query("#dpi_width").value);
  var dpiHeight = int.parse(query("#dpi_height").value);

  var printInWidth = mmWidth/oneInchInMm;
  var printInHeight = mmHeight/oneInchInMm;
  
  var onePtWidth = oneInchInMm/dpiWidth;
  var onePtHeight = oneInchInMm/dpiHeight; 

  var amountPtWidth = printInWidth*dpiWidth;
  var amountPtHeight = printInHeight*dpiHeight;

  var ptPxRatioWidth = (pxWidth/amountPtWidth);
  var ptPxRatioHeight = (pxHeight/amountPtHeight);
  
  query("#print_in_width").text = printInWidth.toString();
  query("#print_in_height").text = printInHeight.toString();
  query("#pt_size_width").text = onePtWidth.toString();
  query("#pt_size_height").text = onePtHeight.toString();
  query("#amount_pt_width").text = amountPtWidth.toString();
  query("#amount_pt_height").text = amountPtHeight.toString();
  query("#pt_px_ratio_width").text = ptPxRatioWidth.toString();
  query("#pt_px_ratio_height").text = ptPxRatioHeight.toString();

}
