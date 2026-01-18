import { View, Text, TextInput, Pressable } from "react-native";
import { useState } from "react";
import { useRouter } from "expo-router";

const BASE_URL = "http://192.168.1.8:5000";

export default function Login() {
  const router = useRouter();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  async function handleLogin() {
    setError("");

    try {
      const res = await fetch(`${BASE_URL}/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password }),
      });

      const data = await res.json();

      if (res.ok) {
        router.replace("/");
      } else {
        setError(data.error || "Login failed");
      }
    } catch (err) {
      console.error(err);
      setError("Network error. Make sure backend is running.");
    }
  }

  return (
    <View className="flex-1 justify-center px-6 bg-black">
      <Text className="text-white text-2xl mb-6">Login</Text>

      {error ? <Text className="text-red-500 mb-4">{error}</Text> : null}

      <TextInput
        className="bg-white rounded px-4 py-3 mb-4"
        placeholder="Username"
        autoCapitalize="none"
        value={username}
        onChangeText={setUsername}
      />

      <TextInput
        className="bg-white rounded px-4 py-3 mb-6"
        placeholder="Password"
        secureTextEntry
        value={password}
        onChangeText={setPassword}
      />

      <Pressable
        onPress={handleLogin}
        className="bg-green-500 py-3 rounded mb-4"
      >
        <Text className="text-center font-bold text-black">Login</Text>
      </Pressable>

      <Pressable onPress={() => router.replace("/register")}>
        <Text className="text-blue-400 text-center">Create account</Text>
      </Pressable>
    </View>
  );
}
