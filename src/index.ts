// Reexport the native module. On web, it will be resolved to ExpoHelpscoutModule.web.ts
// and on native platforms to ExpoHelpscoutModule.ts
export { default } from './ExpoHelpscoutModule';
export { default as ExpoHelpscoutView } from './ExpoHelpscoutView';
export * from  './ExpoHelpscout.types';
