import { useRef, useState } from "react";
import { StyleSheet, Text, View, TouchableOpacity } from "react-native";
import { CameraView, useCameraPermissions } from "expo-camera";

export default function App() {
  const cameraRef = useRef(null);
  const [permission, requestPermission] = useCameraPermissions();
  const [facing, setFacing] = useState("front");

  if (!permission) {
    return <View />;
  }

  if (!permission.granted) {
    return (
      <View style={styles.center}>
        <Text>Camera permission required</Text>
        <TouchableOpacity onPress={requestPermission}>
          <Text style={styles.button}>Grant Permission</Text>
        </TouchableOpacity>
      </View>
    );
  }

  const flipCamera = () => {
    setFacing((current) => (current === "back" ? "front" : "back"));
  };

  const takePhoto = async () => {
    if (!cameraRef.current) return;
    await cameraRef.current.takePictureAsync();
  };

  return (
    <View style={{ flex: 1 }}>
      <CameraView ref={cameraRef} style={styles.camera} facing={facing} />

      <TouchableOpacity style={styles.flip} onPress={flipCamera}>
        <Text style={styles.text}>FLIP</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  camera: {
    flex: 1,
  },
  center: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
  },
  button: {
    marginTop: 12,
    fontSize: 16,
    color: "blue",
  },
  flip: {
    position: "absolute",
    top: 50,
    right: 20,
    backgroundColor: "black",
    padding: 12,
    borderRadius: 20,
  },
  capture: {
    position: "absolute",
    bottom: 40,
    alignSelf: "center",
    backgroundColor: "black",
    padding: 20,
    borderRadius: 40,
  },
  text: {
    color: "white",
    fontWeight: "bold",
  },
});
