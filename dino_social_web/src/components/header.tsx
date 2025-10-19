"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import {
  Search,
  Home,
  Users,
  Video,
  Store,
  Menu,
  MessageCircle,
  Bell,
} from "lucide-react";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export function Header() {
  const pathname = usePathname();

  const navItems = [
    { href: "/", icon: Home, label: "Home" },
    { href: "/friends", icon: Users, label: "Friends" },
    { href: "/video", icon: Video, label: "Video" },
    { href: "/marketplace", icon: Store, label: "Marketplace" },
    { href: "/groups", icon: Menu, label: "Groups" },
  ];

  return (
    <header className="fixed top-0 left-0 right-0 z-50 bg-card border-b shadow-sm">
      <div className="flex items-center justify-between px-4 h-14">
        {/* Left section */}
        <div className="flex items-center gap-2 flex-1">
          <Link
            href="/"
            className="w-10 h-10 rounded-full bg-[#FF5722] flex items-center justify-center text-white font-bold text-xl"
          >
            Dino
          </Link>
          <div className="relative hidden sm:block">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
            <Input
              placeholder="Tìm kiếm trên Dino Social"
              className="pl-10 w-60 bg-secondary border-0 rounded-full"
            />
          </div>
        </div>

        {/* Center navigation */}
        <nav className="hidden md:flex items-center gap-2 flex-1 justify-center">
          {navItems.map((item) => (
            <Link href={item.href} key={item.href}>
              <Button
                variant="ghost"
                size="icon"
                className={`relative h-12 w-20 rounded-lg hover:bg-fb-hover ${
                  pathname === item.href ? "text-primary" : ""
                }`}
              >
                <item.icon className="w-20 h-20" />
                {pathname === item.href && (
                  <div className="absolute bottom-0 left-0 right-0 h-1 bg-primary rounded-t" />
                )}
              </Button>
            </Link>
          ))}
        </nav>

        {/* Right section */}
        <div className="flex items-center gap-2 flex-1 justify-end">
          <Button
            variant="ghost"
            size="icon"
            className="rounded-full bg-secondary hover:bg-fb-active"
          >
            <Menu className="w-5 h-5" />
          </Button>
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button
                variant="ghost"
                size="icon"
                className="rounded-full bg-secondary hover:bg-fb-active"
              >
                <MessageCircle className="w-5 h-5" />
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="end" sticky="partial">
              <DropdownMenuItem href="/messenger">
                <div className="flex flex-col">
                  <p>Bạn có một tin nhắn mới từ An Nguyen.</p>
                  <p className="text-xs text-muted-foreground">5 phút trước</p>
                </div>
              </DropdownMenuItem>
              <DropdownMenuItem>
                <div className="flex flex-col">
                  <p>Minh Tran đã gửi cho bạn một ảnh.</p>
                  <p className="text-xs text-muted-foreground">20 phút trước</p>
                </div>
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button
                variant="ghost"
                size="icon"
                className="rounded-full bg-secondary hover:bg-fb-active relative"
              >
                <Bell className="w-5 h-5" />
                <span className="absolute top-0 right-0 w-5 h-5 bg-red-500 text-white text-xs rounded-full flex items-center justify-center">
                  9
                </span>
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="end" sticky="partial">
              <DropdownMenuItem>
                <div className="flex flex-col">
                  <p>Bạn có một lời mời kết bạn từ Thuc Bui.</p>
                  <p className="text-xs text-muted-foreground">2 giờ trước</p>
                </div>
              </DropdownMenuItem>
              <DropdownMenuItem>
                <div className="flex flex-col">
                  <p>Bài viết của bạn đã có một lượt thích mới.</p>
                  <p className="text-xs text-muted-foreground">3 giờ trước</p>
                </div>
              </DropdownMenuItem>
              <DropdownMenuItem>
                <div className="flex flex-col">
                  <p>Sự kiện "Next.js Conf" sắp diễn ra.</p>
                  <p className="text-xs text-muted-foreground">1 ngày trước</p>
                </div>
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
          <Button variant="ghost" size="icon" className="rounded-full">
            <Avatar className="w-8 h-8">
              <AvatarImage src="https://picsum.photos/seed/myavatar/100/100" />
              <AvatarFallback>QT</AvatarFallback>
            </Avatar>
          </Button>
        </div>
      </div>
    </header>
  );
}
