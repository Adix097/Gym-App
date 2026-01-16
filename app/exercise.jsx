import { Text, View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";

import Camera from "../components/Camera";

const Exercise = () => {
  const count = 10;
  const status = 0;

  return (
    <SafeAreaView className="flex-1 items-center bg-neutral-900 px-4">
      <Text className="mt-6 text-2xl font-bold text-white text-center">
        Exercise name: Push ups
      </Text>

      <View className="mt-10 h-[40%] w-[80%] border-2 border-white bg-white rounded-lg overflow-hidden">
        <Camera />
      </View>

      <Text className="mt-12 text-2xl font-bold text-neutral-300">COUNT</Text>

      <Text className="text-6xl font-extrabold text-yellow-400">{count}</Text>

      <View className="mt-8 flex-row items-center">
        <Text className="text-2xl font-bold text-white">Status:</Text>

        <Text
          className={`ml-2 text-2xl font-bold ${
            status === 0 ? "text-green-400" : "text-red-400"
          }`}
        >
          {status === 0 ? "Tracking" : "Unmonitored"}
        </Text>
      </View>
    </SafeAreaView>
  );
};

export default Exercise;
