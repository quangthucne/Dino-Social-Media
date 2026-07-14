import { LoginPayload } from "@/types/auth/login";
import { axiosInstance } from "@/utils/axiosIntance";

export async function loginApi({ identifier, password }: LoginPayload) {
	const response = await axiosInstance.post("/auth/login", {
		identifier: identifier,
		password: password,
	});
	return response.data;
}
