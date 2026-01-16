import { Text } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Link } from "expo-router";
import { StatusBar } from "expo-status-bar";

const Index = () => {
  return (
    <SafeAreaView className="flex-1 items-center justify-center bg-neutral-900">
      <StatusBar style="light" />

      <Link
        href="./exercise"
        className="text-2xl font-bold text-white underline"
      >
        Go to exercise page →
      </Link>
    </SafeAreaView>
  );
};

export default Index;
