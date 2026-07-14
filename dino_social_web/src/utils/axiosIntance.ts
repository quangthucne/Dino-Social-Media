import axios from "axios";
import { cookies } from "next/dist/server/request/cookies";

export const axiosInstance = axios.create({
	baseURL: "http://127.0.0.1:8080/api",
	headers: {
		"Content-Type": "application/json",
	},
});

// axiosInstance.interceptors.request.use(async (config) => {
// 	try {
// 		const cookieStore = await cookies();
// 		const token = cookieStore.get("token")?.value;
// 		config.headers.Authorization = `Bearer ${token}`;
// 	} catch (error) {
// 		console.error("Lỗi lấy cookie trên Server:", error);
// 	}
// 	return config;
// });
