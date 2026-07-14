"use client";

import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import Logo from "@/assets/dino-logo.png";
import Link from "next/link";
import { loginApi } from "@/apis/auths";
import { loginSchema, LoginSchema } from "@/validations/loginSchema";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import useAuth from "@/hooks/auth/useAuth";

export default function LoginPage() {
	const { login, logout, isAuthenticated } = useAuth();
	// 1. Khởi tạo useForm với Zod resolver

	const {
		register,
		handleSubmit,
		formState: { errors, isSubmitting },
	} = useForm<LoginSchema>({
		resolver: zodResolver(loginSchema),
		defaultValues: {
			identifier: "",
			password: "",
		},
		mode: "onBlur",
	});

	// 2. Hàm xử lý khi submit thành công (đã qua validate)
	const onSubmit = async (data: LoginSchema) => {
		login({ identifier: data.identifier, password: data.password });
	};

	return (
		<div className="flex items-center justify-center min-h-screen bg-background">
			<Card className="w-[75%] sm:max-w-[95%] overflow-hidden">
				<CardContent className="w-full h-full flex">
					<div className="w-1/2">
						<img
							src={Logo.src}
							alt="Login"
							className="w-full h-auto object-fill"
						/>
					</div>
					<div className="w-1/2 justify-center items-center flex flex-col">
						<CardHeader className="text-center pt-2 w-full">
							<CardTitle className="text-2xl font-bold text-chart-1">
								Đăng nhập
							</CardTitle>
							<CardDescription>
								Chào mừng trở lại!
							</CardDescription>
						</CardHeader>
						<div className="w-[90%] flex justify-center">
							<form className="space-y-4 p-2 w-full">
								<div className="space-y-2 ">
									<Label htmlFor="email">
										Tên đăng nhập hoặc email:
									</Label>
									<Input
										id="identifier"
										type="text"
										placeholder="Nhập tên đăng nhập hoặc email"
										{...register("identifier")}
										required
									/>
								</div>
								<div className="space-y-2">
									<Label htmlFor="password">Mật khẩu</Label>
									<Input
										id="password"
										type="password"
										{...register("password")}
										required
									/>
								</div>
								<Button
									type="submit"
									className="w-full bg-chart-1 hover:bg-destructive"
									onClick={handleSubmit(onSubmit)}
									disabled={isSubmitting}
								>
									Đăng nhập
								</Button>
							</form>
						</div>
					</div>

					{/* <div className="mt-4 text-center text-sm">
						Chưa có tài khoản?{" "}
						<Link href="/auth/register" className="underline">
							Đăng ký
						</Link>
					</div> */}
				</CardContent>
			</Card>
		</div>
	);
}
