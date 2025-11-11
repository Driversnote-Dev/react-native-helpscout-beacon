import { registerWebModule, NativeModule } from 'expo';

import { ExpoHelpscoutModuleEvents } from './ExpoHelpscout.types';

class ExpoHelpscoutModule extends NativeModule<ExpoHelpscoutModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ExpoHelpscoutModule, 'ExpoHelpscoutModule');
