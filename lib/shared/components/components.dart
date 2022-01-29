import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_shopping/modules/productDetails/product_details.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/styles/colors.dart';

void navigator(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget(),
      ),
    );

void navigatorWithFinished(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget(),
      ),
      (route) {
        return false;
      },
    );

Widget defaultButtonApp(
        {double width = double.infinity,
        Color background = primaryColor,
        bool isUppercase = true,
        double radius = 4.0,
        required Function function,
        required String text,
        Color textColor = Colors.white}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () => function(),
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
            fontSize: 14.0,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

Widget inputTextFormField({
  required TextEditingController controller,
  required TextInputType keyboard,
  required Function validator,
  required String textLabel,
  IconData? prefixIcon,
  bool isPassword = false,
  bool isClick = true,
  IconData? suffixIcon,
  Function? onTap,
  Function? suffixIconPressed,
  Function? onSubmit,
  Function? onChanged,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: isPassword,
      enabled: isClick,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
        hintText: textLabel,
        hintStyle: const TextStyle(fontSize: 14.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide:
                const BorderSide(style: BorderStyle.solid, color: Colors.red)),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                ),
                onPressed: () => suffixIconPressed!(),
              )
            : null,
      ),
      onTap: () => onTap,
      validator: (value) => validator(value),
      onFieldSubmitted: (value) => onSubmit!(),
      //onChanged: (dynamic value) => onChanged!(value),
    );

Widget inputTextFormFieldNoIcons({
  required TextEditingController controller,
  required TextInputType keyboard,
  required Function validator,
  required String textLabel,
  Function? onTap,
  Function? onSubmit,
  Function? onChanged,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboard,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
        hintText: textLabel,
        hintStyle: const TextStyle(fontSize: 14.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide:
                const BorderSide(style: BorderStyle.solid, color: Colors.red)),
      ),
      onTap: () => onTap,
      validator: (value) => validator(value),
      onFieldSubmitted: (value) => onSubmit!(),
    );

Widget defaultTextButton(
        {String? text, required String btnName, required Function function}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$text',
          style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
        ),
        const SizedBox(
          width: 2.0,
        ),
        TextButton(
          onPressed: () => function(),
          child: Text(
            btnName.toUpperCase(),
            style: const TextStyle(color: primaryColor, fontSize: 12.0),
          ),
        ),
      ],
    );

Widget defaultScreen(
    {required IconData icon,
    required String title,
    required String description}) {
  return Center(
    child: Column(
      children: [
        Icon(
          icon,
          size: 80.0,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 30.0,
        ),
        Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 22.0,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          description,
          style: const TextStyle(color: Colors.grey, fontSize: 16.0),
        ),
      ],
    ),
  );
}

Widget defaultLoginUsing() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'or login using'.toUpperCase(),
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/images/facebook.png'),
              height: 50.0,
              width: 50,
            ),
            SizedBox(
              width: 30.0,
            ),
            Image(
              image: AssetImage('assets/images/google.png'),
              height: 50.0,
              width: 50,
            ),
          ],
        ),
      ],
    );

void toastMessage({required String message, Color? color}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 14.0);
}

Widget buildProfileItems(
    {required IconData icon,
    required String text,
    bool isNewScreen = true,
    required Function function,
    required context}) {
  return InkWell(
    child: Card(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 20.0,
              child: Icon(
                icon,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            // ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              text.toString(),
              style: const TextStyle(fontSize: 14.0),
            ),
            const Spacer(),
            isNewScreen
                ? const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18.0,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    ),
    onTap: () => function(),
  );
}

Widget buildOrderItems({required context, required model}) {
  return InkWell(
    child: Card(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "#" + model.id.toString(),
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      model.total.toString() + " EGP",
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.date_range,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      model.date.toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(4),bottomRight:Radius.circular(4) ),
              color: primaryColor,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                model.status.toString().toUpperCase(),
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget itemAddress({required String text, required String info}) {
  return Row(
    children: [
      Text(
        text,
        style: const TextStyle(
          fontSize: 12.0,
        ),
      ),
      const Spacer(),
      Text(
        info,
        style: const TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

Widget buildListProduct(model, context, {bool isOldPrice = true, index}) =>
    GestureDetector(
      child: Card(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
          ),
          height: 140.0,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Row(
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: 100.0,
                    height: 100.0,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            model.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              model.price.toString(),
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(
                              width: 2.0,
                            ),
                            const Text(
                              'EGP',
                              style: TextStyle(fontSize: 10.0),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            if (model.discount != 0 && isOldPrice)
                              Text(
                                model.oldPrice.toString(),
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .addOrRemoveFavorites(model.id);
                              },
                              icon: CircleAvatar(
                                radius: 15.0,
                                backgroundColor:
                                    ShopCubit.get(context).favorites[model.id]
                                        ? primaryColor
                                        : Colors.grey,
                                child: const Icon(
                                  Icons.favorite_border,
                                  size: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (model.discount != 0 && isOldPrice)
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(4),bottomRight: Radius.circular(4)),
                    color: Colors.red,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(model)));
      },
    );

Widget buildProductItem(model, context, {index}) {
  return GestureDetector(
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: NetworkImage(model.image),
                    width: double.infinity,
                    height: 100.0,
                  ),
                ),
                if (model.discount != 0)
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(10)),
                      color: Colors.red,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      const Text(
                        'EGP',
                        style: TextStyle(fontSize: 10.0),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Color(0xffd7d7d7),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).addOrRemoveFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]
                                  ? primaryColor
                                  : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProductDetailsScreen(model)));
    },
  );
}

