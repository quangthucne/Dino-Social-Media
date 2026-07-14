import type { Metadata } from "next";
import { GeistSans } from "geist/font/sans";
import { GeistMono } from "geist/font/mono";
import { Analytics } from "@vercel/analytics/next";
import { config } from "@fortawesome/fontawesome-svg-core";
import "@fortawesome/fontawesome-svg-core/styles.css";
import "../globals.css";

config.autoAddCss = false;

export const metadata: Metadata = {
	title: "Dino Social",
	description: "Created with DinoTeam",
	generator: "dino-nextjs",
};

export default function AuthLayout({
	children,
}: Readonly<{
	children: React.ReactNode;
}>) {
	return (
		<html lang="vi">
			<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
			<body
				className={`font-sans ${GeistSans.variable} ${GeistMono.variable}`}
				suppressHydrationWarning={true}
			>
				<main className="pt-14">{children}</main>
				<Analytics />
			</body>
		</html>
	);
}
