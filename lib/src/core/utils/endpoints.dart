class CbEndpoints {
  static const baseUrl = "https://cubex-api-shonubijerry.vercel.app/api";
  static const flwbaseUrl = "https://api.flutterwave.com/v3";

  static const login = "/auth/login";

  static const register = "/auth/signup";
  static const verifyEmail = "/auth/verify/";
  static const resendVerifyEmail = "/auth/resend-verification";
  static const validateResetCode = "/auth/validate-reset-token/";
  static const forgotPassword = "/auth/forgot-password";
  static const changePassword = "/auth/change-password";

//wallet
  static const fetchWalletHistory = "/users/wallet-history";

  //terms and condition
  static const termsAndCondition = "/terms-and-conditions/types/";

// user accounts 
  static const fetchUserAccounts = "/user-accounts";
  static const createUserAccounts = "/user-accounts/create";

// upload
  static const upload = "/file/upload";
  //countries
  static const fetchCountries = "/countries";

  //payments
  static const confirmSubscription = "/payments/confirm-subscription";
  static const validateAccountNumber = "/payments/validate-account";
  static const transferCubex = "/payments/transfer-cubex";
  static const transferAccount = "/payments/transfer-account";

  //features
  static const getFeatures = "/features";
  static String getFeatureEnabled(String feature) =>
      "/features/$feature/is-enabled";

  static String updateFeatureStatus(String feature) =>
      "/features/$feature/update-status";

  //banks
  static const fetchBanks = "/banks";

  //product
  static const fetchProducts = "/products";

  //user
  static const fetchUser = "/users/details";
  static const fetchUserBy = "/users/";
  static const editUserDetails = "/users/edit-details";

  //giftcard
  static const fetchGiftCards = "/giftcards";
  static const fetchSingleGiftCard = "/giftcards/one";
  static const createGiftcardTrans = "/giftcards/transaction";

    //crypto
  static const fetchCryptos = "/cryptos";
  static const fetchSingleCryptos = "/cryptos/one";
  static const createCryptosTrans = "/cryptos/transaction";


}
