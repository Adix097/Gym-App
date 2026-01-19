import { View, Text, Pressable, FlatList } from "react-native";
import { Link } from "expo-router";

import LoginLink from "../components/LoginLink";

import useExercises from "../hooks/useExercises";

export default function Dashboard() {
  const { data: exercises, loading, error } = useExercises();

  if (loading) {
    return (
      <View className="flex-1 justify-center items-center bg-black">
        <Text className="text-white text-lg">Loading exercises...</Text>
      </View>
    );
  }

  if (error) {
    return (
      <View className="flex-1 justify-center items-center bg-black px-4">
        <Text className="text-red-500 text-lg mb-4">{error}</Text>
      </View>
    );
  }

  return (
    <View className="flex-1 bg-black px-4 pt-4">
      <LoginLink />

      <FlatList
        data={exercises}
        keyExtractor={(item) => item.name}
        renderItem={({ item }) => (
          <Link
            key={item.name}
            href={`/screens/Exercise/${item.name.replace(" ", "-")}`}
            asChild
          >
            <Pressable className="bg-white rounded-xl p-4 mb-3">
              <Text className="text-lg font-semibold text-black">
                {item.name}
              </Text>
              {item.description ? (
                <Text className="text-black mt-1">{item.description}</Text>
              ) : null}
            </Pressable>
          </Link>
        )}
      />
    </View>
  );
}
