import 'package:flutter/material.dart';


Widget defaultButton({
  double width = double.infinity,
  double height = 50.0,
  double fontSize = 20.0,
  var fontWeight,
  Color? backgroundColor ,
  required   function,
  required String text,
  double radius=50.0,
}) =>
    Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow:  const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0,2),
          ),
        ],
        borderRadius: BorderRadius.circular(radius),
      ),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        color: backgroundColor,
        height: height,
        minWidth: width,
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
            fontWeight: fontWeight
          ),
        ),
      ),
    );

Widget defaultFormField ({
  isPassword=false,
  validate,
   controller ,
  required TextInputType type,
  required String label,
  int maxLines=1,
  double circular=50,
  onTap,
  prefixIcon,
  suffixIcon,
  suffixIconPressed,
  double? width ,
  double? height ,
  bool enabled=true,
  int? errorMaxLines,

})=>SizedBox(
  width: width,
  height: height,
  child:   Material(
    borderRadius: BorderRadius.circular(circular),
    elevation: 5,
    shadowColor: Colors.grey[200],
    child: TextFormField(
      enabled: enabled,
      maxLines: maxLines,

      validator: validate,

      obscureText: isPassword,

      controller: controller,

      keyboardType: type,

      onTap: onTap,

      decoration: InputDecoration(
        errorMaxLines: errorMaxLines,

        labelText: label,


        border: OutlineInputBorder(

          borderRadius:BorderRadius.circular(circular) ,
        ),

          prefixIcon: Icon(prefixIcon),

        suffixIcon: IconButton(

            onPressed: suffixIconPressed,

            icon: Icon(suffixIcon)

        ),

      ),

    ),
  ),
);

void showOverlay({
  required BuildContext context,
  required Widget design,
  double? top,
  double? bottom,
  double? left,
  double? right,
}) {
  final OverlayState? overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    maintainState: true,
    builder: (context) {
      return Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => overlayEntry.remove(),
            ),
          ),
          Positioned(
            top: top,
              bottom: bottom,
              left: left,
              right: right,
              child: Material(child: design),
          ),
        ],
      );
    },
  );
  overlayState?.insert(overlayEntry);
}






Widget noBorderFormField(
    {
       TextEditingController? Controller,
       TextInputType? type,
      BoxDecoration?  decor,
      var onChanged,
      var onSubmitted,
      var Validate,
      var label,
      bool? enabled,
      IconData? prefix,
      TextStyle?style,
      Color?color,
      IconData? suffix,
      bool isPassword =false,
      var suffixPressed,
      double? radius,
    }) =>TextFormField(
  enabled:enabled ,
  validator: Validate,
  controller: Controller,
  keyboardType: type,
  onFieldSubmitted:onSubmitted,
  obscureText: isPassword,
  onChanged: onChanged,
  decoration: InputDecoration(
    labelText: label,
    disabledBorder: InputBorder.none,
    prefixIcon: Icon(
      prefix,  color: Color(0xff1b4b35),),
    suffixIcon:IconButton(
      onPressed: suffixPressed,
      icon: Icon(
          suffix ),
    ),
  ),
);