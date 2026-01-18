import { View, Text } from "react-native";

const Status = ({ status }) => {
  return (
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
  );
};

export default Status;
