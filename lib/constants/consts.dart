export 'colors.dart';
export 'images.dart';
export 'strings.dart';
export 'styles.dart';
export 'sizes.dart';
export 'enums.dart';
export 'package:get/get.dart';
export 'firebase_const.dart';
export 'package:velocity_x/velocity_x.dart';


// Import Customized themes
export 'package:rentndeal/theme/custom_themes/chip_theme.dart';
export 'package:rentndeal/theme/custom_themes/text_theme.dart';
export 'package:rentndeal/theme/custom_themes/appbar_theme.dart';
export 'package:rentndeal/theme/custom_themes/checkbox_theme.dart';
export 'package:rentndeal/theme/custom_themes/text_field_theme.dart';
export 'package:rentndeal/theme/custom_themes/bottom_sheet_theme.dart';
export 'package:rentndeal/theme/custom_themes/elevated_button_theme.dart';
export 'package:rentndeal/theme/custom_themes/outlined_button_theme.dart';


// Helper Function
export 'package:rentndeal/helpers/general_functions/helper_function.dart';
export 'package:rentndeal/helpers/general_functions/device_utility.dart';


//export 'package:rentndeal/consts/colors.dart';
export 'package:rentndeal/constants/lists.dart';



//Import common widgets packages
export 'package:rentndeal/helpers/widgets_common/applogo_widget.dart';
export 'package:rentndeal/helpers/widgets_common/bg_widget.dart';
export 'package:rentndeal/helpers/widgets_common/custom_textfield.dart';
export 'package:rentndeal/helpers/widgets_common/exit_dialog.dart';
export 'package:rentndeal/helpers/widgets_common/home_button.dart';
export 'package:rentndeal/helpers/widgets_common/loading_indicator.dart';
export 'package:rentndeal/helpers/widgets_common/our_button.dart';
export 'package:rentndeal/helpers/widgets_common/text_style.dart';
export 'package:rentndeal/features/Authentication/common_widget/form_divider.dart';
export 'package:rentndeal/features/common_function/shapes/circular_container.dart';


export 'package:rentndeal/helpers/widgets_common/products/product_image.dart';





// Authentication Features

export 'package:rentndeal/features/Authentication/screen/login/login.dart';
export 'package:rentndeal/features/Authentication/screen/signup/signup.dart';
export 'package:rentndeal/features/Authentication/common_widget/social_widget.dart';
export 'package:rentndeal/features/Authentication/screen/EmailVerify/email_verify_success_screen.dart';
export 'package:rentndeal/features/Authentication/screen/ForgetPassword/forget_password.dart';
export 'package:rentndeal/features/Authentication/screen/ForgetPassword/reset_password.dart';


// Location Features






// Firebase & Firestore
export 'package:flutter/material.dart';
export 'package:rentndeal/firebase_options.dart';
export 'package:rentndeal/services/firestore_services.dart';

//Location Library
export 'package:geolocator/geolocator.dart';

export 'package:rentndeal/features/location/widgets/location_dialogs.dart';
export 'package:rentndeal/helpers/location/current_location_fn.dart';
export 'package:google_places_flutter/model/prediction.dart';
export 'package:google_places_flutter/google_places_flutter.dart';

// Icon Library
export 'package:iconsax_flutter/iconsax_flutter.dart';




// Common Widgets

  // Shadow Effect
export 'package:rentndeal/features/common_function/shadow_effect/shadow_style.dart';
  // Text Style
export 'package:rentndeal/features/common_function/text/product_title_text.dart';

export 'package:rentndeal/features/common_function/image_slider_widget.dart';
export 'package:rentndeal/features/common_function/product_widgets/rounded_container.dart';



/// NEW CLASS IMPORT

/// ----- Boarding Screen Feature -----
export 'package:rentndeal/features/onboarding/screen/onboarding.dart';
export 'package:rentndeal/features/onboarding/controller/onboarding_contoller.dart';

/// ----- Common ------
export 'package:rentndeal/features/common_function/text/brand_title_text.dart';
export 'package:rentndeal/features/common_function/text/product_location_in_widget.dart';

export 'package:rentndeal/features/common_function/custom_appbar/custom_tabbar.dart';

export 'package:rentndeal/features/common_function/product_widgets/category_show_case.dart';

export 'package:rentndeal/features/common_function/widgets/category_tab.dart';

export 'package:rentndeal/features/wishlist/screen/wishlist.dart';

export 'package:rentndeal/features/setting/screen/setting.dart';

export 'package:rentndeal/features/common_function/image_text_widgets/circular_image.dart';

export 'package:rentndeal/features/common_function/list_tiles/setting_menu_tile.dart';

export 'package:rentndeal/features/setting/screen/profile.dart';

export 'package:rentndeal/features/product/screens/product_details.dart';

export 'package:rentndeal/features/common_function/product_widgets/product_image_slider.dart';

export 'package:rentndeal/features/common_function/product_widgets/product_metadata.dart';
export 'package:rentndeal/features/common_function/product_widgets/rating_share.dart';

export 'package:rentndeal/features/product/widget/rating_progress_indicator.dart';


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// There is Proper Step by step class Import

// Flutter Packages
export 'package:rentndeal/app.dart';
export 'package:flutter/services.dart';
export 'package:flutter/foundation.dart';
export 'package:get_storage/get_storage.dart';
export 'package:google_sign_in/google_sign_in.dart';


// Firebase Packages
export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_core/firebase_core.dart';


// Application UI Packages
  // Splash Screen
export 'package:flutter_native_splash/flutter_native_splash.dart';
  // OnBoarding Screen

  // Login Screen
export 'package:rentndeal/features/Authentication/screen/EmailVerify/verify_email.dart';

  // Location
export 'package:rentndeal/features/location/screen/first_location.dart';

  // Home Screen
export 'package:rentndeal/features/home/screen/home.dart';
export 'package:rentndeal/features/home/screen/navigation_menu.dart';
export 'package:rentndeal/features/home/controller/homee_controller.dart';

// Category Screen
export 'package:rentndeal/features/category/screen/category_screen.dart';


// Common Functions

    // Custom App Bar
export 'package:rentndeal/features/common_function/custom_appbar/custom_appbar.dart';
    // Backgrouund Screen
export 'package:rentndeal/features/common_function/background_screen/shapes/curved_edges.dart';
export 'package:rentndeal/features/common_function/background_screen/shapes/curve_widget.dart';
export 'package:rentndeal/features/common_function/background_screen/background_screen.dart';
    // Icon Widget
export 'package:rentndeal/features/common_function/icon/circular_icon.dart';
    // Search Bar
export 'package:rentndeal/features/common_function/search_bar/search_bar.dart';
    // Text
export 'package:rentndeal/features/common_function/text/section_heading.dart';
    // Image Text Widget
export 'package:rentndeal/features/common_function/image_text_widgets/vertical_image_text.dart';
    // Product Widgets
export 'package:rentndeal/features/common_function/product_widgets/product_detail_horizontal.dart';
export 'package:rentndeal/features/common_function/product_widgets/product_detail_vertical.dart';
    // Grid View Layout
export 'package:rentndeal/features/common_function/layouts/grid_view_layout.dart';


// Category

//Sub Category
export 'package:rentndeal/features/category/screen/sub_category.dart';

// Chat Screen


// Application Backend Service
export 'package:rentndeal/backend_services/repositories/user_repository.dart';
export 'package:rentndeal/backend_services/repositories/authentication_repository.dart';




// Helper Functions
export 'package:rentndeal/helpers/exceptions/format_exception.dart';
export 'package:rentndeal/helpers/local_storage/storage_utility.dart';
export 'package:rentndeal/helpers/exceptions/platform_exceptions.dart';
export 'package:rentndeal/helpers/exceptions/firebase_exceptions.dart';
export 'package:rentndeal/helpers/exceptions/firebase_auth_exceptions.dart';
