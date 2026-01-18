import { View, Text, Pressable } from "react-native";
import { Link } from "expo-router";

import LoginLink from "../components/LoginLink";

const exercises = ["Push Ups", "Plank"];

export default function Dashboard() {
  return (
    <View className="flex-1 bg-black px-4 pt-4">
      <LoginLink />
      {exercises.map((ex) => (
        <Link key={ex} href={`/screens/Exercise/${ex.replace(" ", "-")}`} asChild>
          <Pressable className="bg-white rounded-xl p-4 mb-3">
            <Text className="text-lg font-semibold text-black">{ex}</Text>
          </Pressable>
        </Link>
      ))}
    </View>
  );
}
