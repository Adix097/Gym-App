import { StyleSheet, Text, View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Link } from "expo-router";
import { StatusBar } from "expo-status-bar";
import { useColorScheme } from "react-native";
import React from "react";

const index = () => {
  return (
    <SafeAreaView style={styles.page}>
      <StatusBar style="light" />
      <Link href="./exercise" style={styles.link}>
        Go to exercise page →
      </Link>
    </SafeAreaView>
  );
};

export default index;

const styles = StyleSheet.create({
  page: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#222",
  },
  link: {
    fontSize: 24,
    fontWeight: "bold",
    fontFamily: "Inter",
    color: "#fff",
    textDecorationLine: "underline",
  },
});
