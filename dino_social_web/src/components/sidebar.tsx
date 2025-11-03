import { Home, Users, Video, Store, Clock, ChevronDown } from "lucide-react";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";

export function Sidebar() {
  const menuItems = [
    { icon: Home, label: "Dino AI", active: true },
    { icon: Users, label: "Bạn bè" },
    { icon: Video, label: "Nhóm" },
    { icon: Store, label: "Marketplace" },
    { icon: Clock, label: "Kỷ niệm" },
  ];

  return (
    <aside className="hidden lg:block w-80 fixed left-0 top-14 h-[calc(100vh-3.5rem)] overflow-y-auto p-2">
      <nav className="space-y-1">
        <Button
          variant="ghost"
          className="w-full justify-start gap-3 h-12 px-2"
        >
          <Avatar className="w-9 h-9">
            <AvatarImage src="https://picsum.photos/seed/myavatar/100/100" />
            <AvatarFallback>QT</AvatarFallback>
          </Avatar>
          <span className="font-semibold">Quang Thực</span>
        </Button>

        {menuItems.map((item) => (
          <Button
            key={item.label}
            variant="ghost"
            className={`w-full justify-start gap-3 h-12 px-2 ${
              item.active ? "bg-fb-hover" : ""
            }`}
          >
            <div className="w-9 h-9 flex items-center justify-center">
              <item.icon className="w-6 h-6 text-[#FF5722] " />
            </div>
            <span className="font-medium">{item.label}</span>
          </Button>
        ))}

        <Button
          variant="ghost"
          className="w-full justify-start gap-3 h-12 px-2"
        >
          <div className="w-9 h-9 flex items-center justify-center bg-secondary rounded-full">
            <ChevronDown className="w-5 h-5" />
          </div>
          <span className="font-medium">Xem thêm</span>
        </Button>
      </nav>

      <div className="mt-4 pt-4 border-t">
        <h3 className="px-2 text-muted-foreground font-semibold text-sm mb-2">
          Lối tắt của bạn
        </h3>
        <div className="space-y-1">
          <Button
            variant="ghost"
            className="w-full justify-start gap-3 h-12 px-2"
          >
            <Avatar className="w-9 h-9 rounded-lg">
              <AvatarImage src="https://picsum.photos/seed/shortcut1/100/100" />
              <AvatarFallback>HT</AvatarFallback>
            </Avatar>
            <span className="font-medium">HỒNG HỐT CẦN THƠ</span>
          </Button>
          <Button
            variant="ghost"
            className="w-full justify-start gap-3 h-12 px-2"
          >
            <Avatar className="w-9 h-9 rounded-lg">
              <AvatarImage src="https://picsum.photos/seed/shortcut2/100/100" />
              <AvatarFallback>CD</AvatarFallback>
            </Avatar>
            <span className="font-medium">CODE THUÊ ĐỒ ÁN</span>
          </Button>
        </div>
      </div>
    </aside>
  );
}
