import { StyleSheet, Text, View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";

import Camera from "../components/Camera";
import Spacer from "../components/Spacer";

const exercise = () => {
  let count = 10;
  let status = 0;
  return (
    <SafeAreaView style={styles.page}>
      <Spacer />
      <Text style={styles.exerciseTitle}>Exercise name: Push ups</Text>
      <Spacer height={80} />
      <View style={styles.cameraFrame}>
        <Camera />
      </View>
      <Spacer height={120} />
      <Text style={styles.countTitle}>COUNT</Text>
      <Text style={styles.count}>{count}</Text>
      <Spacer />
      <View style={styles.statusView}>
        <Text style={styles.status}>Status: </Text>
        {status === 0 ? (
          <Text style={[styles.status, { color: "rgb(0, 255, 0)" }]}>
            tracking
          </Text>
        ) : (
          <Text style={[styles.status, { color: "rgb(255, 0, 0)" }]}>
            Unmonitored
          </Text>
        )}
      </View>
    </SafeAreaView>
  );
};

export default exercise;

const styles = StyleSheet.create({
  page: {
    flex: 1,
    alignItems: "center",
    backgroundColor: "#222",
  },
  exerciseTitle: {
    fontWeight: "bold",
    fontSize: 28,
    color: "#fff",
    textAlign: "center",
  },
  cameraFrame: {
    height: "40%",
    width: "80%",
    border: "2px solid white",
    backgroundColor: "#fff",
  },
  countTitle: {
    fontWeight: "bold",
    fontSize: 28,
    color: "#dddddd",
    textAlign: "center",
  },
  count: {
    fontWeight: "bolder",
    fontSize: 64,
    color: "#ffe043",
    textAlign: "center",
    fontFamily: "console",
  },
  statusView: {
    flexDirection: "row",
  },
  status: {
    fontWeight: "bold",
    fontSize: 28,
    color: "#fff",
    textAlign: "center",
  },
});
