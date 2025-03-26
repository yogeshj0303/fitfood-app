import 'package:fit_food/Constants/export.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword,
    this.isEmail,
    this.isPhone,
    required this.iconData,
  });
  final TextEditingController controller;
  final IconData iconData;
  final String hintText;
  final bool? isPassword;
  final bool? isEmail;
  final bool? isPhone;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.isPhone ?? false
              ? TextInputType.number
              : TextInputType.name,
          obscureText: widget.isPassword ?? false ? showPassword : false,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: widget.isPassword ?? false
                ? IconButton(
                    onPressed: () {
                      showPassword = !showPassword;
                      isPasswordVisible = !isPasswordVisible;
                      setState(() {});
                    },
                    icon: showPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: Style.smallLighttextStyle,
            fillColor: Colors.black12,
            filled: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Icon(widget.iconData),
            ),
          ),
          validator: (value) {
            const pattern =
                r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
            final regExp = RegExp(pattern);
            if (widget.isPassword ?? false) {
              if (value!.isEmpty) {
                return 'Enter password';
              } else if (value.length < 6) {
                return 'Enter atleast 6 letter password';
              }
            } else if (widget.isEmail ?? false) {
              if (value!.isEmpty) {
                return 'Enter an E-mail';
              } else if (!regExp.hasMatch(value.trim())) {
                return 'Enter an valid E-mail address';
              }
            } else if (widget.isPhone ?? false) {
              if (value!.isEmpty) {
                return 'Enter your Mobile number';
              } else if (value.length != 10) {
                return 'Enter an valid 10 digit Mobile number';
              }
            } else {
              if (value!.isEmpty) {
                return 'This is required';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
