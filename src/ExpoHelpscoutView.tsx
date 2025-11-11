import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpoHelpscoutViewProps } from './ExpoHelpscout.types';

const NativeView: React.ComponentType<ExpoHelpscoutViewProps> =
  requireNativeView('ExpoHelpscout');

export default function ExpoHelpscoutView(props: ExpoHelpscoutViewProps) {
  return <NativeView {...props} />;
}
