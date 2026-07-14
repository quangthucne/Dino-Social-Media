import { LoginResponse } from "./login";

export interface AuthState {
	isAuthenticated: boolean;
	token: string | null;
	refreshToken: string | null;
	login: ({ token, refreshToken }: LoginResponse) => void;
	logout: () => void;
}
