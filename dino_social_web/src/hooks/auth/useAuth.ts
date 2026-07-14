"use client";
import { loginApi } from "@/apis/auths";
import { useAuthStore } from "@/stores/auth/authStore";
import { LoginPayload } from "@/types/auth/login";
import { useMutation } from "@tanstack/react-query";
import router from "next/router";

export default function useAuth() {
	// Add your authentication logic here
	const { login, logout, isAuthenticated, token, refreshToken } =
		useAuthStore();

	const loginMutation = useMutation({
		mutationFn: (payload: LoginPayload) =>
			loginApi({
				identifier: payload.identifier,
				password: payload.password,
			}),
		onSuccess: (data) => {
			// Handle successful login if needed
			login(data.data);
			router.push("/");
		},
		onError: (error) => {
			// Handle login error if needed
			console.error("Login error:", error);
		},
	});

	const handleLogin = (payload: LoginPayload) => {
		return loginMutation.mutate(payload);
	};

	const resetLoginState = () => {
		loginMutation.reset();
	};

	const handleLogout = async () => {
		await logout();
		// clear store or any other necessary cleanup
		router.push("/");
	};

	return {
		isAuthenticated,
		token,
		refreshToken,
		loginMutation,
		login: handleLogin,
		logout: handleLogout,
		resetLoginState,
	};
}
