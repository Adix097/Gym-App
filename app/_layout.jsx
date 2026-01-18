import { Stack } from "expo-router";
import { SafeAreaView } from "react-native-safe-area-context";
import "../global.css";

export default function RootLayout() {
  return (
    <SafeAreaView className="flex-1 bg-black">
      <Stack
        screenOptions={{
          headerStyle: { backgroundColor: "#222" },
          headerTintColor: "#ddd",
          contentStyle: { backgroundColor: "#000" },
        }}
      >
        <Stack.Screen name="index" options={{ title: "GYM-APP" }} />
        <Stack.Screen name="screens/Auth/login" options={{ title: "Login" }} />
        <Stack.Screen
          name="screens/Auth/register"
          options={{ title: "Register" }}
        />
        <Stack.Screen
          name="screens/Exercise/[name]"
          options={{ title: "Exercise" }}
        />
        <Stack.Screen
          name="screens/dashboard"
          options={{ title: "Dashboard" }}
        />
      </Stack>
    </SafeAreaView>
  );
}
