import { Header } from "@/components/header";
import { Sidebar } from "@/components/sidebar";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
  Play,
  ThumbsUp,
  MessageCircle,
  Share2,
  MoreHorizontal,
} from "lucide-react";

export default function VideoPage() {
  const videos = [
    {
      id: 1,
      author: "Lan Hương",
      time: "Hôm qua lúc 14:03",
      title: "Cách chụp ảnh đọc đôi ảnh nền điện thoại...",
      thumbnail: "https://picsum.photos/seed/video1/600/400",
      views: "10K",
      likes: "77 bình luận",
      comments: "1,5 triệu lượt xem",
    },
    {
      id: 2,
      author: "Trắng TV",
      time: "5 giờ trước",
      title: "Video mới của Trắng TV và những người khác.",
      thumbnail: "https://picsum.photos/seed/video2/600/400",
      views: "50K",
      likes: "120 bình luận",
      comments: "2,3 triệu lượt xem",
    },
    {
      id: 3,
      author: "Nguyễn Trâm",
      time: "2 ngày trước",
      title: "Hướng dẫn nấu ăn ngon mỗi ngày",
      thumbnail: "https://picsum.photos/seed/video3/600/400",
      views: "25K",
      likes: "89 bình luận",
      comments: "890K lượt xem",
    },
  ];

  return (
    <div className="min-h-screen bg-background">
      <Header />
      <div className="flex pt-14">
        <Sidebar />

        <main className="flex-1 lg:ml-80 p-4">
          <div className="max-w-2xl mx-auto">
            <div className="mb-6">
              <h1 className="text-2xl font-bold mb-4">Video</h1>
              <div className="flex gap-2 overflow-x-auto pb-2">
                <Button
                  variant="secondary"
                  className="rounded-lg whitespace-nowrap"
                >
                  <Play className="w-4 h-4 mr-2" />
                  Trang chủ
                </Button>
                <Button
                  variant="ghost"
                  className="rounded-lg whitespace-nowrap"
                >
                  Trực tiếp
                </Button>
                <Button
                  variant="ghost"
                  className="rounded-lg whitespace-nowrap"
                >
                  Reels
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
                  Video đã lưu
                </Button>
              </div>
            </div>

            <div className="space-y-6">
              {videos.map((video) => (
                <Card key={video.id} className="overflow-hidden">
                  <div className="p-4">
                    <div className="flex items-center justify-between mb-3">
                      <div className="flex items-center gap-3">
                        <Avatar>
                          <AvatarImage src="https://picsum.photos/seed/avatar/100/100" />
                          <AvatarFallback>{video.author[0]}</AvatarFallback>
                        </Avatar>
                        <div>
                          <p className="font-semibold">{video.author}</p>
                          <p className="text-sm text-muted-foreground">
                            {video.time}
                          </p>
                        </div>
                      </div>
                      <Button variant="ghost" size="icon">
                        <MoreHorizontal className="w-5 h-5" />
                      </Button>
                    </div>
                    <p className="mb-3">{video.title}</p>
                  </div>

                  <div className="relative bg-black aspect-video group cursor-pointer">
                    <img
                      src={video.thumbnail || "https://picsum.photos/600/400"}
                      alt={video.title}
                      className="w-full h-full object-cover"
                    />
                    <div className="absolute inset-0 bg-black/20 group-hover:bg-black/30 transition-colors flex items-center justify-center">
                      <div className="w-16 h-16 rounded-full bg-white/90 flex items-center justify-center">
                        <Play
                          className="w-8 h-8 text-black ml-1"
                          fill="black"
                        />
                      </div>
                    </div>
                    <div className="absolute bottom-4 right-4 bg-black/80 text-white px-2 py-1 rounded text-sm">
                      {video.views} lượt xem
                    </div>
                  </div>

                  <div className="p-4">
                    <div className="flex items-center justify-between text-sm text-muted-foreground mb-3">
                      <span>{video.likes}</span>
                      <span>{video.comments}</span>
                    </div>
                    <div className="flex items-center justify-around border-t pt-2">
                      <Button variant="ghost" className="flex-1">
                        <ThumbsUp className="w-5 h-5 mr-2" />
                        Thích
                      </Button>
                      <Button variant="ghost" className="flex-1">
                        <MessageCircle className="w-5 h-5 mr-2" />
                        Bình luận
                      </Button>
                      <Button variant="ghost" className="flex-1">
                        <Share2 className="w-5 h-5 mr-2" />
                        Chia sẻ
                      </Button>
                    </div>
                  </div>
                </Card>
              ))}
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}