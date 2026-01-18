import { View, Text, TextInput, Pressable } from "react-native";
import { useState } from "react";
import { useRouter } from "expo-router";

const BASE_URL = "http://192.168.1.8:5000";

export default function Register() {
  const router = useRouter();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");

  async function handleRegister() {
    setError("");
    setSuccess("");

    try {
      const res = await fetch(`${BASE_URL}/register`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password }),
      });

      const data = await res.json();

      if (res.ok) {
        setSuccess("Account created");
        setTimeout(() => router.replace("/login"), 800);
      } else {
        setError(data.error || "Registration failed");
      }
    } catch (err) {
      console.error(err);
      setError("Network error. Make sure backend is running.");
    }
  }

  return (
    <View className="flex-1 justify-center px-6 bg-black">
      <Text className="text-white text-2xl mb-6">Register</Text>

      {error ? <Text className="text-red-500 mb-4">{error}</Text> : null}
      {success ? <Text className="text-green-500 mb-4">{success}</Text> : null}

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
        onPress={handleRegister}
        className="bg-green-500 py-3 rounded mb-4"
      >
        <Text className="text-center font-bold text-black">Register</Text>
      </Pressable>

      <Pressable onPress={() => router.replace("/login")}>
        <Text className="text-blue-400 text-center">
          Already have an account?
        </Text>
      </Pressable>
    </View>
  );
}
