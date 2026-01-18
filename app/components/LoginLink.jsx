import { View, Pressable, Text } from "react-native";
import { Link } from "expo-router";

const LoginLink = () => {
  return (
    <View className="flex-row justify-end mb-4">
      <Link href="../screens/Auth/login" asChild>
        <Pressable hitSlop={10}>
          <Text className="text-blue-400 font-semibold text-lg">LOGIN</Text>
        </Pressable>
      </Link>
    </View>
  );
};

export default LoginLink;
