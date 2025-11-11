import { useEvent } from 'expo';
import ExpoHelpscout from 'expo-helpscout';
import { useEffect } from 'react';
import { Button, SafeAreaView, ScrollView, Text, View } from 'react-native';

const beaconId = "";
const userEmail = "";
const userName = "";

export default function App() {

 useEffect(() => {
  ExpoHelpscout.init(beaconId);
  ExpoHelpscout.identify(userEmail, userName);
 })

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView style={styles.container}>
        <Text style={styles.header}>Helpscout Example</Text>
        <Button
          title="Open Helpscout"
          onPress={async () => {
            await ExpoHelpscout.open();
          }}
        />
      </ScrollView>
    </SafeAreaView>
  );
}


const styles = {
  header: {
    fontSize: 30,
    margin: 20,
  },
  container: {
    flex: 1,
    backgroundColor: '#eee',
  },
};
