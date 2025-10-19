import { Header } from "@/components/header";
import { Sidebar } from "@/components/sidebar";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Search, Settings, Users } from "lucide-react";
import { Input } from "@/components/ui/input";

export default function GroupsPage() {
  const myGroups = [
    {
      name: "HỒNG HỐT CẦN THƠ",
      members: "15K thành viên",
      image: "https://picsum.photos/seed/group1/200/200",
      unread: 5,
    },
    {
      name: "CODE THUÊ ĐỒ ÁN, BÀI TẬP LỚN",
      members: "25K thành viên",
      image: "https://picsum.photos/seed/group2/200/200",
      unread: 12,
    },
    {
      name: "Hà Trần POLY Group",
      members: "8K thành viên",
      image: "https://picsum.photos/seed/group3/200/200",
      unread: 0,
    },
    {
      name: "Cao Đẳng Thực Hành FPT Polytechnic",
      members: "50K thành viên",
      image: "https://picsum.photos/seed/group4/200/200",
      unread: 3,
    },
  ];

  const suggestedGroups = [
    {
      name: "Lập Trình Viên Việt Nam",
      members: "120K thành viên",
      image: "https://picsum.photos/seed/suggested_group1/400/300",
    },
    {
      name: "Mua Bán Đồ Cũ Hà Nội",
      members: "85K thành viên",
      image: "https://picsum.photos/seed/suggested_group2/400/300",
    },
    {
      name: "Du Lịch Việt Nam",
      members: "200K thành viên",
      image: "https://picsum.photos/seed/suggested_group3/400/300",
    },
  ];

  return (
    <div className="min-h-screen bg-background">
      <Header />
      <div className="flex pt-14">
        <Sidebar />

        <main className="flex-1 lg:ml-80 p-4">
          <div className="max-w-5xl mx-auto">
            <div className="mb-6">
              <div className="flex items-center justify-between mb-4">
                <h1 className="text-2xl font-bold">Nhóm</h1>
                <Button variant="ghost" size="icon">
                  <Settings className="w-5 h-5" />
                </Button>
              </div>

              <div className="relative mb-4">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                <Input
                  placeholder="Tìm kiếm nhóm"
                  className="pl-10 bg-secondary border-0 rounded-lg"
                />
              </div>

              <div className="flex gap-2 overflow-x-auto pb-2">
                <Button
                  variant="secondary"
                  className="rounded-lg whitespace-nowrap"
                >
                  <Users className="w-4 h-4 mr-2" />
                  Nhóm của bạn
                </Button>
                <Button
                  variant="ghost"
                  className="rounded-lg whitespace-nowrap"
                >
                  Khám phá
                </Button>
                <Button
                  variant="ghost"
                  className="rounded-lg whitespace-nowrap"
                >
                  Đã tham gia
                </Button>
              </div>
            </div>

            <section className="mb-8">
              <h2 className="text-xl font-bold mb-4">Nhóm của bạn</h2>
              <div className="space-y-3">
                {myGroups.map((group) => (
                  <Card
                    key={group.name}
                    className="p-4 cursor-pointer hover:bg-fb-hover transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <img
                        src={group.image || "https://picsum.photos/200/200"}
                        alt={group.name}
                        className="w-16 h-16 rounded-lg object-cover"
                      />
                      <div className="flex-1">
                        <h3 className="font-semibold">{group.name}</h3>
                        <p className="text-sm text-muted-foreground">
                          {group.members}
                        </p>
                        {group.unread > 0 && (
                          <p className="text-sm text-primary font-medium mt-1">
                            {group.unread} bài viết mới
                          </p>
                        )}
                      </div>
                    </div>
                  </Card>
                ))}
              </div>
            </section>

            <section>
              <h2 className="text-xl font-bold mb-4">Nhóm được đề xuất</h2>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {suggestedGroups.map((group) => (
                  <Card key={group.name} className="overflow-hidden">
                    <img
                      src={group.image || "https://picsum.photos/400/300"}
                      alt={group.name}
                      className="w-full h-40 object-cover"
                    />
                    <div className="p-4">
                      <h3 className="font-semibold mb-1">{group.name}</h3>
                      <p className="text-sm text-muted-foreground mb-3">
                        {group.members}
                      </p>
                      <Button className="w-full bg-[#1877F2] hover:bg-[#1664D8]">
                        Tham gia nhóm
                      </Button>
                    </div>
                  </Card>
                ))}
              </div>
            </section>
          </div>
        </main>
      </div>
    </div>
  );
}