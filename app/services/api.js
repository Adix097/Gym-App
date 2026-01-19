const BASE_URL = "http://192.168.1.8:5000";

export default async function getExercises() {
  const res = await fetch(`${BASE_URL}/exercises`);
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  const data = await res.json();
  return data;
}
