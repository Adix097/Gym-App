import { useRef, useState } from "react";
import { Text, View, TouchableOpacity } from "react-native";
import { CameraView, useCameraPermissions } from "expo-camera";

export default function Camera() {
  const cameraRef = useRef(null);
  const [permission, requestPermission] = useCameraPermissions();
  const [facing, setFacing] = useState("front");

  if (!permission) {
    return <View />;
  }

  if (!permission.granted) {
    return (
      <View className="flex-1 flex items-center justify-center">
        <Text>Camera permission required</Text>
        <TouchableOpacity onPress={requestPermission}>
          <Text className="mt-3 text-base text-blue-500">Grant Permission</Text>
        </TouchableOpacity>
      </View>
    );
  }

  const flipCamera = () => {
    setFacing((current) => (current === "back" ? "front" : "back"));
  };

  return (
    <View className="mt-10 h-[50%] w-[80%] border-2 border-white bg-white rounded-lg overflow-hidden">
      <CameraView ref={cameraRef} style={{ flex: 1 }} facing={facing} />
      <TouchableOpacity
        className="absolute top-[50px] right-5 bg-black p-3 rounded-[20px]"
        onPress={flipCamera}
      >
        <Text className="text-white font-bold">FLIP</Text>
      </TouchableOpacity>
    </View>
  );
}
