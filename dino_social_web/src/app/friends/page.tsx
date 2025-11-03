import { Sidebar } from "@/components/sidebar";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { UserPlus, Users } from "lucide-react";

export default function FriendsPage() {
  const friendRequests = [
    {
      name: "Tùng Giang",
      mutualFriends: "Có 1.4K người theo dõi",
      image: "https://picsum.photos/seed/friend1/400/300",
    },
    {
      name: "Kim Thắm",
      mutualFriends: "Có 1.2K người theo dõi",
      image: "https://picsum.photos/seed/friend2/400/300",
    },
    {
      name: "Đất Nền AN Khánh",
      mutualFriends: "Có 1.2K người theo dõi",
      image: "https://picsum.photos/seed/friend3/400/300",
    },
    {
      name: "Nguyễn An Ninh",
      mutualFriends: "1 bạn chung",
      image: "https://picsum.photos/seed/friend4/400/300",
    },
    {
      name: "Fullstack Dev",
      mutualFriends: "Không có bạn chung",
      image: "https://picsum.photos/seed/friend5/400/300",
    },
    {
      name: "Hoàng Tiến",
      mutualFriends: "2 bạn chung",
      image: "https://picsum.photos/seed/friend6/400/300",
    },
  ];

  const suggestions = [
    {
      name: "Thiên Tuế",
      mutualFriends: "2 bạn chung",
      image: "https://picsum.photos/seed/suggestion1/400/300",
    },
    {
      name: "Thuỷ Vy",
      mutualFriends: "2 bạn chung",
      image: "https://picsum.photos/seed/suggestion2/400/300",
    },
    {
      name: "Đức Lê",
      mutualFriends: "Không có bạn chung",
      image: "https://picsum.photos/seed/suggestion3/400/300",
    },
  ];

  return (
    <div className="min-h-screen bg-background">
      <div className="flex">
        <Sidebar />

        <main className="flex-1 lg:ml-80 p-4 max-w-5xl">
          <div className="mb-6">
            <h1 className="text-2xl font-bold mb-4">Bạn bè</h1>
            <div className="flex gap-2">
              <Button variant="secondary" className="rounded-lg">
                <Users className="w-4 h-4 mr-2" />
                Trang chủ
              </Button>
              <Button variant="ghost" className="rounded-lg">
                Lời mời kết bạn
              </Button>
              <Button variant="ghost" className="rounded-lg">
                Gợi ý
              </Button>
              <Button variant="ghost" className="rounded-lg">
                Tất cả bạn bè
              </Button>
            </div>
          </div>

          <section className="mb-8">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-xl font-bold">Lời mời kết bạn</h2>
              <Button variant="link" className="text-primary">
                Xem tất cả
              </Button>
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {friendRequests.map((request) => (
                <Card key={request.name} className="overflow-hidden">
                  <img
                    src={request.image || "https://picsum.photos/400/300"}
                    alt={request.name}
                    className="w-full h-48 object-cover"
                  />
                  <div className="p-4">
                    <h3 className="font-semibold text-lg mb-1">
                      {request.name}
                    </h3>
                    <p className="text-sm text-muted-foreground mb-3">
                      {request.mutualFriends}
                    </p>
                    <div className="space-y-2">
                      <Button className="w-full bg-[#1877F2] hover:bg-[#1664D8]">
                        Xác nhận
                      </Button>
                      <Button variant="secondary" className="w-full">
                        Xóa
                      </Button>
                    </div>
                  </div>
                </Card>
              ))}
            </div>
          </section>

          <section>
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-xl font-bold">Những người bạn có thể biết</h2>
              <Button variant="link" className="text-primary">
                Xem tất cả
              </Button>
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {suggestions.map((suggestion) => (
                <Card key={suggestion.name} className="overflow-hidden">
                  <img
                    src={suggestion.image || "https://picsum.photos/400/300"}
                    alt={suggestion.name}
                    className="w-full h-48 object-cover"
                  />
                  <div className="p-4">
                    <h3 className="font-semibold text-lg mb-1">
                      {suggestion.name}
                    </h3>
                    <p className="text-sm text-muted-foreground mb-3">
                      {suggestion.mutualFriends}
                    </p>
                    <Button className="w-full" variant="secondary">
                      <UserPlus className="w-4 h-4 mr-2" />
                      Thêm bạn bè
                    </Button>
                  </div>
                </Card>
              ))}
            </div>
          </section>
        </main>
      </div>
    </div>
  );
}
