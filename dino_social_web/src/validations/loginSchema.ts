import { z } from "zod";

export const loginSchema = z.object({
	identifier: z.string().min(1, "Vui lòng nhập tên đăng nhập hoặc email"),
	password: z.string().min(6, "Vui lòng nhập mật khẩu"),
});

export type LoginSchema = z.infer<typeof loginSchema>;
