import { View, Text, Pressable } from "react-native";
import { useRouter } from "expo-router";

export default function Index() {
  const router = useRouter();

  return (
    <View className="flex-1 bg-black px-4 pt-8 justify-center">
      <Text className="text-white text-2xl font-bold mb-8 text-center">
        Welcome
      </Text>

      <Pressable
        className="bg-white rounded-xl p-4 mb-4"
        onPress={() => router.push("/screens/Auth/login")}
      >
        <Text className="text-black text-lg font-semibold text-center">
          Login
        </Text>
      </Pressable>

      <Pressable
        className="bg-white rounded-xl p-4 mb-4"
        onPress={() => router.push("/screens/Auth/register")}
      >
        <Text className="text-black text-lg font-semibold text-center">
          Register
        </Text>
      </Pressable>

      <Pressable
        onPress={() => router.push("/screens/dashboard")}
      >
        <Text className="text-white text-lg font-semibold text-center">
          Use Without Login
        </Text>
      </Pressable>
    </View>
  );
}
