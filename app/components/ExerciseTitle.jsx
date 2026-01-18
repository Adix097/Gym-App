import { Text, View } from "react-native";

const ExerciseTitle = ({ exerciseName }) => {
  return (
    <Text className="mt-6 text-2xl font-bold text-white text-center">
      Exercise Name: {exerciseName}
    </Text>
  );
};

export default ExerciseTitle;
