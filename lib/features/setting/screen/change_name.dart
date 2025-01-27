
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/setting/controller/update_name_controller.dart';
import 'package:rentndeal/helpers/general_functions/validator.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text('Change Name', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Use real name for easy verification. This name will appear on several pages.', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: CSizes.spaceBtwSections),

            // Text Field nad Button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => Validator.validateEmptyText('First name', value),
                    expands: false,
                    decoration: const InputDecoration(labelText: CString.firstName, prefixIcon: Icon(Iconsax.user)),
                  ),
                  const SizedBox(height: CSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => Validator.validateEmptyText('Last name', value),
                    expands: false,
                    decoration: const InputDecoration(labelText: CString.lastName, prefixIcon: Icon(Iconsax.user)),
                  ),
                ]
              )
            ),
            const SizedBox(height: CSizes.spaceBtwInputFields),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.updateUserName(), child: const Text('Save')),
            )
          ],
        ),),
    );
  }
}