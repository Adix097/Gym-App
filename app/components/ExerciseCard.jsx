import { Text, Pressable} from "react-native";
import { Link } from "expo-router";

const ExerciseCard = ({exercise}) => {
  return (
    <Link
      key={exercise.name}
      href={`/screens/Exercise/${exercise.name.replace(" ", "-")}`}
      asChild
    >
      <Pressable className="bg-white rounded-xl p-4 mb-3">
        <Text className="text-lg font-semibold text-black">{exercise.name}</Text>
        {exercise.description ? (
          <Text className="text-black mt-1">{exercise.description}</Text>
        ) : null}
      </Pressable>
    </Link>
  );
};

export default ExerciseCard;
