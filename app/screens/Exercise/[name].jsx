import { SafeAreaView } from "react-native-safe-area-context";
import { useLocalSearchParams } from "expo-router";

import Camera from "../../components/Camera";
import ExerciseTitle from "../../components/ExerciseTitle";
import Counter from "../../components/Counter";
import Status from "../../components/Status";

export default function Exercise() {
  const { name } = useLocalSearchParams();

  const count = 0;
  const status = 0;

  return (
    <SafeAreaView className="flex-1 items-center bg-neutral-900 px-4">
      <ExerciseTitle exerciseName={name} />
      <Camera />
      <Counter count={count} />
      <Status status={status} />
    </SafeAreaView>
  );
}
