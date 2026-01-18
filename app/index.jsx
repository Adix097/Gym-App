import { View, Text, Pressable } from "react-native";
import { Link } from "expo-router";

const exercises = ["Push Ups", "Plank"];

export default function Index() {
  return (
    <View className="flex-1 bg-black px-4 pt-4">
      <View className="flex-row justify-end mb-4">
        <Link href="./login" asChild>
          <Pressable hitSlop={10}>
            <Text className="text-blue-400 font-semibold text-lg">LOGIN</Text>
          </Pressable>
        </Link>
      </View>
      {exercises.map((ex) => (
        <Link key={ex} href={`/exercise/${ex.replace(" ", "-")}`} asChild>
          <Pressable className="bg-white rounded-xl p-4 mb-3">
            <Text className="text-lg font-semibold text-black">{ex}</Text>
          </Pressable>
        </Link>
      ))}
    </View>
  );
}
