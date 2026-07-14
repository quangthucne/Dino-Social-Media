import { loginApi } from "@/apis/auths";
import { AuthState } from "@/types/auth/auth-state";
import { LoginPayload, LoginResponse } from "@/types/auth/login";
import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";

const initState: AuthState = {
	isAuthenticated: false,
	token: null,
	refreshToken: null,
	login: ({ token, refreshToken }: LoginResponse) => {},
	logout: () => {},
};

export const useAuthStore = create<AuthState>()(
	persist(
		(set) => ({
			...initState,
			// 2. Xử lý logic đăng nhập
			login: async ({ token, refreshToken }: LoginResponse) => {
				set({
					isAuthenticated: true,
					token: token,
					refreshToken: refreshToken,
				});
			},

			// 3. Xử lý đăng xuất
			logout: () => {
				set({
					...initState,
				});
				localStorage.removeItem("auth-storage");
			},
		}),
		{
			name: "auth-storage", // Tên key trong LocalStorage
			storage: createJSONStorage(() => localStorage), // Cách viết chuẩn cho Web
		}
	)
);
