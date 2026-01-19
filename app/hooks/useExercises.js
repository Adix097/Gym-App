import { useEffect, useState } from "react";
import getExercises from "../services/api";

export default function useExercises() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    getExercises()
      .then(setData)
      .catch(() => setError("Failed to load exercises"))
      .finally(() => setLoading(false));
  }, []);

  return { data, loading, error };
}
