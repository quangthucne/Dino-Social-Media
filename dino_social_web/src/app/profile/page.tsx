import { Header } from "@/components/header";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
  Camera,
  Plus,
  Edit,
  MoreHorizontal,
  ImageIcon,
  Video,
  Smile,
} from "lucide-react";
import { Post } from "@/components/post";

export default function ProfilePage() {
  const posts = [
    {
      id: 1,
      author: "Quang Thức",
      time: "2 giờ",
      content: "Hôm nay thật là một ngày tuyệt vời! 🌟",
      image: "https://picsum.photos/seed/post1/600/400",
      likes: 125,
      comments: 23,
      shares: 5,
    },
  ];

  return (
    <div className="min-h-screen bg-background">
      <Header />

      <main className="pt-14">
        <div className="max-w-5xl mx-auto">
          {/* Cover Photo */}
          <Card className="overflow-hidden mb-4">
            <div className="relative h-96 bg-gradient-to-br from-blue-400 to-purple-500">
              <img
                src="https://picsum.photos/seed/cover/1200/400"
                alt="Cover"
                className="w-full h-full object-cover"
              />
              <Button className="absolute bottom-4 right-4 bg-white text-black hover:bg-gray-100">
                <Camera className="w-4 h-4 mr-2" />
                Chỉnh sửa ảnh bìa
              </Button>
            </div>

            {/* Profile Info */}
            <div className="relative px-6 pb-4">
              <div className="flex flex-col md:flex-row md:items-end md:justify-between -mt-20 md:-mt-8">
                <div className="flex flex-col md:flex-row items-center md:items-end gap-4">
                  <div className="relative">
                    <Avatar className="w-40 h-40 border-4 border-card">
                      <AvatarImage src="https://picsum.photos/seed/myavatar/160/160" />
                      <AvatarFallback className="text-4xl">QT</AvatarFallback>
                    </Avatar>
                    <Button
                      size="icon"
                      className="absolute bottom-2 right-2 rounded-full w-9 h-9 bg-secondary hover:bg-fb-active"
                    >
                      <Camera className="w-4 h-4" />
                    </Button>
                  </div>
                  <div className="text-center md:text-left mb-4">
                    <h1 className="text-3xl font-bold">Quang Thức</h1>
                    <p className="text-muted-foreground">1,234 bạn bè</p>
                    <div className="flex -space-x-2 mt-2 justify-center md:justify-start">
                      {[1, 2, 3, 4, 5].map((i) => (
                        <Avatar
                          key={i}
                          className="w-8 h-8 border-2 border-card"
                        >
                          <AvatarImage
                            src={`https://picsum.photos/seed/friend${i}/32/32`}
                          />
                          <AvatarFallback>F{i}</AvatarFallback>
                        </Avatar>
                      ))}
                    </div>
                  </div>
                </div>
                <div className="flex gap-2 w-full md:w-auto">
                  <Button className="flex-1 md:flex-none bg-[#1877F2] hover:bg-[#1664D8]">
                    <Plus className="w-4 h-4 mr-2" />
                    Thêm vào tin
                  </Button>
                  <Button variant="secondary" className="flex-1 md:flex-none">
                    <Edit className="w-4 h-4 mr-2" />
                    Chỉnh sửa trang cá nhân
                  </Button>
                  <Button variant="secondary" size="icon">
                    <MoreHorizontal className="w-5 h-5" />
                  </Button>
                </div>
              </div>
            </div>

            {/* Navigation Tabs */}
            <div className="border-t px-6">
              <div className="flex gap-2 overflow-x-auto">
                <Button
                  variant="ghost"
                  className="rounded-none border-b-4 border-primary font-semibold px-4 py-3"
                >
                  Bài viết
                </Button>
                <Button
                  variant="ghost"
                  className="rounded-none font-semibold px-4 py-3 hover:bg-fb-hover"
                >
                  Giới thiệu
                </Button>
                <Button
                  variant="ghost"
                  className="rounded-none font-semibold px-4 py-3 hover:bg-fb-hover"
                >
                  Bạn bè
                </Button>
                <Button
                  variant="ghost"
                  className="rounded-none font-semibold px-4 py-3 hover:bg-fb-hover"
                >
                  Ảnh
                </Button>
                <Button
                  variant="ghost"
                  className="rounded-none font-semibold px-4 py-3 hover:bg-fb-hover"
                >
                  Video
                </Button>
                <Button
                  variant="ghost"
                  className="rounded-none font-semibold px-4 py-3 hover:bg-fb-hover"
                >
                  Xem thêm
                </Button>
              </div>
            </div>
          </Card>

          {/* Content Grid */}
          <div className="grid grid-cols-1 lg:grid-cols-5 gap-4">
            {/* Left Column */}
            <div className="lg:col-span-2 space-y-4">
              <Card className="p-4">
                <h2 className="font-bold text-xl mb-4">Giới thiệu</h2>
                <Button variant="secondary" className="w-full mb-3">
                  Thêm tiểu sử
                </Button>
                <div className="space-y-3 text-sm">
                  <p className="text-center text-muted-foreground">
                    Chưa có thông tin để hiển thị
                  </p>
                </div>
                <Button variant="secondary" className="w-full mt-4">
                  Chỉnh sửa chi tiết
                </Button>
              </Card>

              <Card className="p-4">
                <div className="flex items-center justify-between mb-4">
                  <h2 className="font-bold text-xl">Ảnh</h2>
                  <Button variant="link" className="text-primary">
                    Xem tất cả ảnh
                  </Button>
                </div>
                <div className="grid grid-cols-3 gap-2">
                  {[1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) => (
                    <div
                      key={i}
                      className="aspect-square rounded-lg overflow-hidden"
                    >
                      <img
                        src={`https://picsum.photos/seed/photo${i}/150/150`}
                        alt={`Photo ${i}`}
                        className="w-full h-full object-cover hover:opacity-90 transition-opacity cursor-pointer"
                      />
                    </div>
                  ))}
                </div>
              </Card>

              <Card className="p-4">
                <div className="flex items-center justify-between mb-4">
                  <h2 className="font-bold text-xl">Bạn bè</h2>
                  <Button variant="link" className="text-primary">
                    Xem tất cả bạn bè
                  </Button>
                </div>
                <p className="text-sm text-muted-foreground mb-3">
                  1,234 người bạn
                </p>
                <div className="grid grid-cols-3 gap-2">
                  {[1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) => (
                    <div key={i} className="text-center">
                      <img
                        src={`https://picsum.photos/seed/friend_grid${i}/100/100`}
                        alt={`Friend ${i}`}
                        className="w-full aspect-square rounded-lg object-cover mb-1"
                      />
                      <p className="text-xs font-medium truncate">Bạn bè {i}</p>
                    </div>
                  ))}
                </div>
              </Card>
            </div>

            {/* Right Column - Posts */}
            <div className="lg:col-span-3 space-y-4">
              <Card className="p-4">
                <div className="flex gap-2 mb-4">
                  <Avatar>
                    <AvatarImage src="https://picsum.photos/seed/myavatar/100/100" />
                    <AvatarFallback>QT</AvatarFallback>
                  </Avatar>
                  <Button
                    variant="secondary"
                    className="flex-1 justify-start text-muted-foreground"
                  >
                    Thức ơi, bạn đang nghĩ gì thế?
                  </Button>
                </div>
                <div className="flex justify-around border-t pt-3">
                  <Button variant="ghost" className="flex-1">
                    <Video className="w-5 h-5 mr-2 text-red-500" />
                    Video trực tiếp
                  </Button>
                  <Button variant="ghost" className="flex-1">
                    <ImageIcon className="w-5 h-5 mr-2 text-green-500" />
                    Ảnh/video
                  </Button>
                  <Button variant="ghost" className="flex-1">
                    <Smile className="w-5 h-5 mr-2 text-yellow-500" />
                    Cảm xúc/hoạt động
                  </Button>
                </div>
              </Card>

              {posts.map((post) => (
                <Post key={post.id} {...post} />
              ))}
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}