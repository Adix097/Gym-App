import { Text } from "react-native";

const Counter = ({ count }) => {
  return (
    <>
      <Text className="mt-12 text-2xl font-bold text-neutral-300">COUNT</Text>
      <Text className="text-6xl font-extrabold text-yellow-400">{count}</Text>
    </>
  );
};

export default Counter;