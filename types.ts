export type HelpScoutBeaconType = {
  init: (beaconId: string) => void;
  identify: (email: string, name?: string) => void;
  identifyWithEmailAndName: (email: string, name?: string) => void;
  login: (email: string, name: string, userId: string) => void;
  loginAndOpen: (
    email: string,
    name: string,
    userId: string,
    signature?: string
  ) => void;
  open: (signature?: string) => void;
  navigate: (path: string) => void;
  logout: () => void;
  addAttributeWithKey: (key: string, value: string) => void;
  openArticle: (articleID: string, signature: string | undefined) => void;
  suggestArticles: (articleIDList: Array<string>) => void;
  resetSuggestions: () => void;
};

declare const module: HelpScoutBeaconType;

export default module;
