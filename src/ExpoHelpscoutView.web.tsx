import * as React from 'react';

import { ExpoHelpscoutViewProps } from './ExpoHelpscout.types';

export default function ExpoHelpscoutView(props: ExpoHelpscoutViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
