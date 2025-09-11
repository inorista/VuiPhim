import 'package:flutter/material.dart';
import 'package:vuiphim/presentation/utils/custom_form_field.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: height,
          width: width,
          child: CustomFormField(controller: controller),
        ),
      ),
    );
  }
}
