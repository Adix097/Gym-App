const BASE_URL = "https://gardant-unvain-arletta.ngrok-free.dev";

export default async function getExercises() {
  const res = await fetch(`${BASE_URL}/exercises`);
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  const data = await res.json();
  return data;
}
