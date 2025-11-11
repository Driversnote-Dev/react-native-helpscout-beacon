import { NativeModule, requireNativeModule } from 'expo';


declare class ExpoHelpscoutModule extends NativeModule {
  /**
   * Initialize the Helpscout Beacon SDK with your Beacon ID.
   */
  init(beaconID: string): void;

  /**
   * Identify the user with email and optional name.
   */
  identify(email: string, name?: string): void;

  /**
   * Add a custom attribute to the identified user.
   */
  addAttributeWithKey(key: string, value: string): void;

  /**
   * Open the Beacon UI. Optionally include a signature key.
   */
  open(signatureKey?: string): void;

  /**
   * Navigate to a specific Beacon path.
   * Example paths: "ask", "chat", "email", "article/{id}"
   */
  navigate(path: string): void;

  /**
   * Logs out the currently identified user.
   */
  logout(): void;

  /**
   * Opens a specific article in the Beacon.
   */
  openArticle(articleID: string, signature?: string): void;

  /**
   * Suggest specific articles to show in the Beacon.
   */
  suggestArticles(articleIDList: string[]): void;

  /**
   * Reset suggested articles.
   */
  resetSuggestions(): void;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoHelpscoutModule>('ExpoHelpscout');
