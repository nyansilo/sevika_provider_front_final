import 'package:flutter/material.dart';

/// Centralized Layout Design Tokens Engine for the Application Ecosystem.
///
/// Strictly coordinates all padding, margins, structural gaps, corner radii,
/// typography baselines, and component boundaries. This file serves as the
/// single source of truth to maintain strict visual consistency across views.
class AppDimensions {
  const AppDimensions._(); // Prevents instantiation

  /// ==========================================
  /// 1. GENERIC RAW GRAPHIC METRICS
  /// Base raw sizing points used for explicit height/width assignments.
  /// ==========================================
  static const double size4 = 4.0;
  static const double size8 = 8.0;
  static const double size9 = 9.0;
  static const double size10 = 10.0;
  static const double size11 = 11.0;
  static const double size12 = 12.0;
  static const double size14 = 14.0;
  static const double size16 = 16.0;
  static const double size18 = 18.0;
  static const double size20 = 20.0;
  static const double size22 = 22.0;
  static const double size24 = 24.0;
  static const double size25 = 25.0;
  static const double size26 = 26.0;
  static const double size28 = 28.0;
  static const double size30 = 30.0;
  static const double size32 = 32.0;
  static const double size35 = 35.0;
  static const double size36 = 36.0;
  static const double size40 = 40.0;
  static const double size45 = 45.0;
  static const double size48 = 48.0;
  static const double size50 = 50.0;
  static const double size56 = 56.0;
  static const double size60 = 60.0;
  static const double size64 = 64.0;
  static const double size65 = 65.0;
  static const double size70 = 70.0;
  static const double size72 = 72.0;

  static const double size75 = 75.0;

  static const double size80 = 80.0;
  static const double size96 = 96.0;
  static const double size110 = 110.0;
  static const double size120 = 120.0;
  static const double size140 = 140.0;
  static const double size160 = 160.0;
  static const double size180 = 180.0;
  static const double size200 = 200.0;
  static const double size205 = 205.0;
  static const double size220 = 220.0;
  static const double size260 = 260.0;
  static const double size320 = 320.0;
  static const double size400 = 400.0;
  static const double size450 = 450.0;
  static const double size500 = 500.0;
  static const double size800 = 800.0;

  /// ==========================================
  /// 2. ABSOLUTE STRUCTURAL LAYOUT MAX CEILINGS
  /// Responsive layout boundaries to prevent stretching on larger screens or tablets.
  /// ==========================================

  /// Max width constraint for login, registration, and input form layouts.
  static const double maxFormContentWidth = size450;

  /// Max width layout limit for onboarding swipe illustrations and text panels.
  static const double maxOnboardingWidth = size500;

  /// Max structural width for the main dashboard feed to preserve clean spacing on tablets.
  static const double maxDashboardWidth = size800;

  /// Max width threshold for modal bottom sheet containers.
  static const double maxModalBottomSheetWidth = 600.0;

  /// ==========================================
  /// 3. COMPONENT SPECIFIC METRIC CONSTRAINTS
  /// Tailored heights and widths for unique core branding and transaction components.
  /// ==========================================

  /// Precise height constraint for rendering the corporate app brand logo assets.
  static const double logoHeight = size64;

  /// Large width allocation for high-resolution corporate logo branding placements.
  static const double logoWidthLarge = 180.0;

  /// Height for the structural home promotional banner and hero carousel frame.
  static const double heroCarouselHeight = size160;

  /// Maximum horizontal width threshold for promotional banners on compact viewports.
  static const double heroBannerWidthMobileMax = size400;

  /// Scroll boundary height layout for the horizontal "Featured Professionals" listview.
  static const double featuredProScrollHeight = size205;

  /// Fixed horizontal card width for professional item preview components.
  static const double featuredProCardWidth = size320;

  /// Square image container scale bounds for horizontal recommendation feeds.
  static const double recommendedImageSize = size80;

  /// Height constraint for the credit card / wallet account card visualization widget.
  static const double walletCardHeight = 185.0;

  /// Vertical layout height for a single standard item container row inside the ledger list view.
  static const double transactionRowHeight = size72;

  /// ==========================================
  /// 4. GRID LAYOUT MATRIX CONSTRAINTS
  /// Exact dimensions controlling cross-axis grid tiles.
  /// ==========================================

  /// Max item width boundary allowed before an item wraps inside the home services category grid.
  static const double categoryGridMaxExtent = 180.0;

  /// Strict height boundary constraint for a single category service button icon/text tile.
  static const double categoryGridItemHeight = 110.0;

  /// Max item width boundary allowed before an item wraps inside secondary grid layers.
  static const double productGridMaxExtent = 160.0;

  /// Height constraint for cards nested within complex storefront or auxiliary grid matrix items.
  static const double productGridItemHeight = 220.0;

  /// ==========================================
  /// 5. AVATAR & BADGE MEASUREMENTS
  /// Standard sizing parameters for user profile representations and count indicators.
  /// ==========================================

  /// Small circular profile picture template size (e.g., inside header app bars).
  static const double avatarS = size32;

  /// Medium circular profile template size (e.g., inside service review list tiles).
  static const double avatarM = size48;

  /// Large circular profile picture size (e.g., centered on the account settings root view).
  static const double avatarL = size72;

  /// Large profile viewport fallback boundary token.
  static const double avatarSizeLarge = size64;

  /// Corner radius value to construct small round container masks.
  static const double avatarRadiusS = size16;

  /// Corner radius value to construct medium round container masks.
  static const double avatarRadiusM = size24;

  /// Corner radius value to construct large round container masks.
  static const double avatarRadiusL = size36;

  /// Micro icon constraint for handling notification badges or verification checkmark layers.
  static const double badgeIconSize = size12;

  /// Size boundary for unread message indicator dots.
  static const double badgeDotSize = 10.0;

  /// ==========================================
  /// 6. GLOBAL ICON SIZE SCALE
  /// Highly consistent action element scale rules across the entire app interface.
  /// ==========================================
  static const double iconXXS = size12;
  static const double iconXS = size14;
  static const double iconS = size16;
  static const double iconM =
      size20; // Default standard size for standard action icons
  static const double iconL =
      size24; // Secondary size for prominent app bar trailing items
  static const double iconXL = size28;
  static const double iconXXL = size48;

  /// ==========================================
  /// 7. GLOBAL PADDING & MARGIN SCALE (8-dp grid baseline)
  /// Defines spacing layouts, page margins, gaps, and view container paddings.
  /// ==========================================
  static const double paddingXXS =
      size4 / 2; // 2.0: Ultra-tight card inner spacing boundaries
  static const double paddingXS = 6.0; // Tight stack component groupings
  static const double paddingS = size8; // 8.0: Micro list item intervals
  static const double paddingSM = 10.0; // Compact field intervals
  static const double paddingM =
      size16; // 16.0: The core application side margin/gutter default
  static const double paddingL =
      size24; // 24.0: Generous block container divisions
  static const double paddingXL =
      size32; // 32.0: Large structural section buffers
  static const double paddingXXL =
      size40; // 40.0: Extensive hero section header stack offsets
  static const double paddingXXXL =
      size64; // 64.0: Maximum dynamic page tail clearance spaces

  /// ==========================================
  /// 8. BORDER RADIUS SCALE
  /// Enforces perfect corner roundness attributes for design cohesion.
  /// ==========================================
  static const double radiusXXS = 2.0;
  static const double radiusXS = size4; // 4.0: Sharp alert banners or mini tags
  static const double radiusS =
      size8; // 8.0: Form inputs and small button designs
  static const double radiusM =
      size12; // 12.0: Standard wallet card containers / Service tiles
  static const double radiusL =
      size16; // 16.0: Large dialog popups and bottom sheets
  static const double radiusXL =
      size24; // 24.0: Prominent informational feature sliders
  static const double radiusXXL = size32; // 32.0: Full capsule layouts
  static const double radiusCircular =
      999.0; // Perfect circle masks / Pill shaped elements

  /// ==========================================
  /// 9. INTERACTIVE ELEMENTS CONSTRAINTS
  /// Touch target constraints ensuring ergonomic physical interactions.
  /// ==========================================

  /// Core target height for call-to-action primary forms and buttons.
  static const double targetButtonHeight = size56;

  /// Compact height rule for secondary or inline card button items.
  static const double compactButtonHeight = size40;

  /// Fixed icon bounding dimension for social login buttons or auxiliary shares.
  static const double socialIconSize = 28.0;

  /// Height boundary for standard text input layout controls.
  static const double inputFieldHeight = 56.0;

  /// ==========================================
  /// 10. CONSTANT UNIFORM SQUARE SPACERS (SizedBox Ecosystem)
  /// Combined spacers for quick vertical or horizontal layout adjustments.
  /// ==========================================
  static const SizedBox gapXXS = SizedBox(
    height: paddingXXS,
    width: paddingXXS,
  );
  static const SizedBox gapXS = SizedBox(height: paddingXS, width: paddingXS);
  static const SizedBox gapS = SizedBox(height: paddingS, width: paddingS);
  static const SizedBox gapM = SizedBox(height: paddingM, width: paddingM);
  static const SizedBox gapSM = SizedBox(height: paddingM, width: paddingSM);
  static const SizedBox gapL = SizedBox(height: paddingL, width: paddingL);
  static const SizedBox gapXL = SizedBox(height: paddingXL, width: paddingXL);
  static const SizedBox gapXXL = SizedBox(
    height: paddingXXL,
    width: paddingXXL,
  );

  static const SizedBox gapXXXL = SizedBox(height: 100, width: paddingXXL);

  /// ==========================================
  /// 11. DEDICATED DIRECTIONAL LAYOUT SPACERS
  /// Optimized explicit vertical and horizontal spacing blocks to eliminate boilerplate.
  /// ==========================================

  // Explicit Vertical Gaps
  static const SizedBox gapVXXS = SizedBox(height: paddingXXS);
  static const SizedBox gapVXS = SizedBox(height: paddingXS);
  static const SizedBox gapVS = SizedBox(height: paddingS);
  static const SizedBox gapVSM = SizedBox(height: paddingSM);
  static const SizedBox gapVM = SizedBox(
    height: paddingM,
  ); // Standard layout row separator (16.0)
  static const SizedBox gapVL = SizedBox(
    height: paddingL,
  ); // Pronounced card layout separator (24.0)
  static const SizedBox gapVXL = SizedBox(height: paddingXL);
  static const SizedBox gapVXXL = SizedBox(height: paddingXXL);

  // Explicit Horizontal Gaps
  static const SizedBox gapHXXS = SizedBox(width: paddingXXS);
  static const SizedBox gapHXS = SizedBox(width: paddingXS);
  static const SizedBox gapHS = SizedBox(
    width: paddingS,
  ); // Standard item/text icon spacer (8.0)
  static const SizedBox gapHSM = SizedBox(width: paddingSM);
  static const SizedBox gapHM = SizedBox(
    width: paddingM,
  ); // Standard structural element inline spacer (16.0)
  static const SizedBox gapHL = SizedBox(width: paddingL);
  static const SizedBox gapHXL = SizedBox(width: paddingXL);
  static const SizedBox gapHXXL = SizedBox(width: paddingXXL);

  /// ==========================================
  /// 12. STRUCTURAL NAVIGATION LAYOUT CONSTRAINTS
  /// Navigation component sizing.
  /// ==========================================

  /// Persistent bottom app navigation layout background bar height.
  static const double bottomNavBarHeight = size64;

  /// Base navigation fallback height metric for the generic app header block.
  static const double topAppBarHeight = 56.0;

  /// Protective separation gap edge margin wrapping docked floating action buttons.
  static const double fabNotchMargin = size8;

  /// Width boundary framework buffer around central functional navigation overlays.
  static const double fabClearanceWidth = size48;

  /// Fixed canvas bounding dimension for primary action buttons.
  static const double fabIconSize = size32;

  /// Navigation icon control element scale boundary parameter.
  static const double navIconSize = size24;

  /// Structural divider line thickness applied to bottom app borders.
  static const double navBorderThin = 0.5;

  /// ==========================================
  /// 13. CORE GRAPHIC COMPONENT SPECIFICATIONS (WEIGHTS & ALPHAS)
  /// Structural border widths, division parameters, and backdrop opacity targets.
  /// ==========================================

  /// Ultra-light division lines used inside composite cards or lists.
  static const double borderWidthThin = 1.0;

  /// Intermediate active item contour outline indicator weight metric.
  static const double borderWidthMedium = 1.5;

  /// Strong focus boundary outline thickness weight tracker metric.
  static const double borderWidthThick = 2.0;

  /// Fine typographic item hairline score division baseline thickness.
  static const double borderThicknessThin = 0.3;

  /// Default standard outline item border tracking thickness parameter.
  static const double borderThicknessMedium = 1.5;

  /// Thick container block divider framework stroke boundary line.
  static const double borderThicknessThick = 0.5;

  /// Muted outline boundary configuration transparency factor value target.
  static const double borderAlphaMuted = 0.3;

  /// Subtle contour tracking background border outline opacity indicator value.
  static const double borderAlphaSubtle = 0.5;

  static const double opacitySubtle = 0.2;

  /// Light card fill translucent color alpha scaling multiplier token.
  static const double containerAlphaLow = 0.2;

  /// Medium container opacity factor assignment tracker index level token.
  static const double containerAlphaMed = 0.25;

  /// Dense structural overlay layout content shielding opacity parameter target.
  static const double containerAlphaHigh = 0.85;

  static const double catalogCardAspectRatio = 0.76;

  /// ==========================================
  /// 14. FINE TYPOGRAPHY SCALES & LINE METRICS
  /// Exact font sizes and proportional layout height relationships.
  /// ==========================================

  /// Tiny detail string labels (e.g., transaction timeline timestamps, tiny form alerts).

  static const double fontSizeCaption = 12.0;
  static const double fontSizeTarget = 12.0;

  /// Small uppercase descriptive text caps labels layer tags components.
  static const double fontSizeOverline = 11.0;

  /// Subdued informational content body text blocks (e.g., secondary service descriptions).
  static const double fontSizeBodySecondary = 13.0;

  /// Primary paragraph typography scale choice (e.g., transaction list description strings).
  static const double fontSizeBodyPrimary = 15.0;

  /// Section structural text headers or prominent profile setting identifiers.
  static const double fontSizeSubheading = 18.0;

  /// Standard page view header tracking identifier item labels canvas rules.
  static const double fontSizeHeading = 22.0;

  /// Prominent metrics text (e.g., digital currency wallet total ledger numbers).
  static const double fontSizeDisplay = 32.0;

  /// Strict vertical typographic scale bounding factor ratio constraint for tracking titles.
  static const double lineHeightTight = 1.3;

  /// Standard conversational reading text line box spacing layout metric tracking modifier.
  static const double lineHeightNormal = 1.4;

  /// Extended clear paragraph text bounding layout row multiplier factor configuration.
  static const double lineHeightTight15 = 1.5;
}
