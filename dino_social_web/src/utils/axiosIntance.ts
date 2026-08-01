import axios from "axios";

export const axiosInstance = axios.create({
	baseURL: "http://127.0.0.1:8080/api",
	headers: {
		"Content-Type": "application/json",
	},
});

// Add client-side request interceptor to attach JWT token from Zustand localStorage
if (typeof window !== "undefined") {
	axiosInstance.interceptors.request.use((config) => {
		try {
			const authStorage = localStorage.getItem("auth-storage");
			if (authStorage) {
				const state = JSON.parse(authStorage).state;
				const token = state?.token;
				if (token) {
					config.headers.Authorization = `Bearer ${token}`;
				}
			}
		} catch (error) {
			console.error("Lỗi khi lấy token từ localStorage:", error);
		}
		return config;
	});
}
