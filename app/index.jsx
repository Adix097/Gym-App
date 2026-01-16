import { View, Text, Pressable } from "react-native";
import { Link } from "expo-router";

const exercises = ["Push Ups", "Plank"];

export default function Index() {
  return (
    <View className="flex-1 bg-black p-4">
      {exercises.map((ex) => (
        <Link
          key={ex}
          href={`/exercise/${ex.replace(" ", "-")}`}
          asChild
        >
          <Pressable className="bg-white rounded-lg p-4 mb-3 shadow-md">
            <Text className="text-lg font-bold text-black">{ex}</Text>
          </Pressable>
        </Link>
      ))}
    </View>
  );
}
