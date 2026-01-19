import { View, Text, FlatList } from "react-native";

import LoginLink from "../components/LoginLink";
import ExerciseCard from "../components/ExerciseCard";

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
          <ExerciseCard exercise={item}/>
        )}
      />
    </View>
  );
}
