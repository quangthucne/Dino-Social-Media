import { Header } from "@/components/header";
import { Sidebar } from "@/components/sidebar";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { MoreHorizontal } from "lucide-react";

export default function NotificationsPage() {
  const notifications = [
    {
      id: 1,
      user: "Phạm Hoàng Phương Nam",
      action: "đã bình luận về trang thái bạn chia sẻ.",
      time: "8 giờ",
      avatar: "https://picsum.photos/seed/notification1/100/100",
      unread: true,
      icon: "💬",
    },
    {
      id: 2,
      user: "Phạm Hoàng Phương Nam",
      action:
        "đã bày tỏ cảm xúc về bình luận của bạn: Phạm Hoàng Phương Nam...",
      time: "6 giờ · 1 cảm xúc",
      avatar: "https://picsum.photos/seed/notification2/100/100",
      unread: true,
      icon: "😂",
    },
    {
      id: 3,
      user: "Vũ Thái",
      action: "đã chia sẻ bài viết của bạn.",
      time: "7 giờ",
      avatar: "https://picsum.photos/seed/notification3/100/100",
      unread: true,
      icon: "🔄",
    },
    {
      id: 4,
      user: "Ngocquy Huynh",
      action: "và 3 người khác đã bày tỏ cảm xúc về một ảnh.",
      time: "6 giờ",
      avatar: "https://picsum.photos/seed/notification4/100/100",
      unread: true,
      icon: "😂",
    },
    {
      id: 5,
      user: "Huỳnh Như",
      action: "đã thêm vào tin của mình.",
      time: "13 giờ",
      avatar: "https://picsum.photos/seed/notification5/100/100",
      unread: false,
      icon: "📖",
    },
    {
      id: 6,
      user: "Ví Khiêm",
      action: "đã nhắc đến bạn trong một bình luận.",
      time: "1 ngày",
      avatar: "https://picsum.photos/seed/notification6/100/100",
      unread: false,
      icon: "💬",
    },
  ];

  return (
    <div className="min-h-screen bg-background">
      <Header />
      <div className="flex pt-14">
        <Sidebar />

        <main className="flex-1 lg:ml-80 p-4">
          <div className="max-w-2xl mx-auto">
            <Card className="mb-4">
              <div className="p-4">
                <div className="flex items-center justify-between mb-4">
                  <h1 className="text-2xl font-bold">Thông báo</h1>
                  <Button variant="ghost" size="icon">
                    <MoreHorizontal className="w-5 h-5" />
                  </Button>
                </div>
                <div className="flex gap-2">
                  <Button variant="secondary" className="rounded-lg">
                    Tất cả
                  </Button>
                  <Button variant="ghost" className="rounded-lg">
                    Chưa đọc
                  </Button>
                </div>
              </div>
            </Card>

            <div className="space-y-1">
              <div className="px-4 py-2">
                <h2 className="font-semibold">Hôm nay</h2>
              </div>
              {notifications.slice(0, 4).map((notification) => (
                <Card
                  key={notification.id}
                  className={`p-4 cursor-pointer hover:bg-fb-hover transition-colors ${
                    notification.unread ? "bg-blue-50 dark:bg-blue-950/20" : ""
                  }`}
                >
                  <div className="flex gap-3">
                    <div className="relative">
                      <Avatar className="w-14 h-14">
                        <AvatarImage
                          src={notification.avatar || "https://picsum.photos/100/100"}
                        />
                        <AvatarFallback>{notification.user[0]}</AvatarFallback>
                      </Avatar>
                      <div className="absolute -bottom-1 -right-1 w-7 h-7 bg-blue-500 rounded-full flex items-center justify-center text-sm">
                        {notification.icon}
                      </div>
                    </div>
                    <div className="flex-1">
                      <p className="text-sm">
                        <span className="font-semibold">
                          {notification.user}
                        </span>{" "}
                        {notification.action}
                      </p>
                      <p className="text-xs text-primary mt-1">
                        {notification.time}
                      </p>
                    </div>
                    {notification.unread && (
                      <div className="w-3 h-3 bg-primary rounded-full mt-2" />
                    )}
                  </div>
                </Card>
              ))}

              <div className="px-4 py-2 mt-4">
                <h2 className="font-semibold">Trước đó</h2>
              </div>
              {notifications.slice(4).map((notification) => (
                <Card
                  key={notification.id}
                  className="p-4 cursor-pointer hover:bg-fb-hover transition-colors"
                >
                  <div className="flex gap-3">
                    <div className="relative">
                      <Avatar className="w-14 h-14">
                        <AvatarImage
                          src={notification.avatar || "https://picsum.photos/100/100"}
                        />
                        <AvatarFallback>{notification.user[0]}</AvatarFallback>
                      </Avatar>
                      <div className="absolute -bottom-1 -right-1 w-7 h-7 bg-blue-500 rounded-full flex items-center justify-center text-sm">
                        {notification.icon}
                      </div>
                    </div>
                    <div className="flex-1">
                      <p className="text-sm">
                        <span className="font-semibold">
                          {notification.user}
                        </span>{" "}
                        {notification.action}
                      </p>
                      <p className="text-xs text-muted-foreground mt-1">
                        {notification.time}
                      </p>
                    </div>
                  </div>
                </Card>
              ))}
            </div>

            <div className="text-center py-6">
              <Button variant="link" className="text-primary">
                Xem thông báo trước đó
              </Button>
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}