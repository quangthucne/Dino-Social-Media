"use client"; // Add this at the top

import Link from "next/link"; // Import Link
import { Plus } from "lucide-react";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Card } from "@/components/ui/card";

export function Stories() {
  const stories = [
    {
      id: 1,
      name: "Tạo tin",
      image: "https://picsum.photos/seed/story0/200/300",
      isCreate: true,
    },
    {
      id: 2,
      name: "Vũ Thị Lan Ánh",
      image: "https://picsum.photos/seed/story1/200/300",
    },
    {
      id: 3,
      name: "Lắc Đầu",
      image: "https://picsum.photos/seed/story2/200/300",
    },
    {
      id: 4,
      name: "VNPAY",
      image: "https://picsum.photos/seed/story3/200/300",
    },
    {
      id: 5,
      name: "Thông tin Chính phủ",
      image: "https://picsum.photos/seed/story4/200/300",
    },
    {
      id: 6,
      name: "Nguyễn Văn A",
      image: "https://picsum.photos/seed/story5/200/300",
    },
    {
      id: 7,
      name: "Trần Thị B",
      image: "https://picsum.photos/seed/story6/200/300",
    },
    {
      id: 8,
      name: "Lê Văn C",
      image: "https://picsum.photos/seed/story7/200/300",
    },
    {
      id: 9,
      name: "Phạm Thị D",
      image: "https://picsum.photos/seed/story8/200/300",
    },
    {
      id: 10,
      name: "Hoàng Văn E",
      image: "https://picsum.photos/seed/story9/200/300",
    },
  ];

  return (
    <div className="bg-card rounded-lg shadow p-2 mb-4">
      <div className="flex gap-2 overflow-x-auto pb-2">
        {stories.map((story) => (
          <Link
            href={story.isCreate ? "#" : `/stories/stories-detail`}
            key={story.id}
          >
            <Card className="relative flex-shrink-0 w-28 h-48 overflow-hidden cursor-pointer hover:brightness-95 transition">
              <img
                src={story.image || "https://picsum.photos/200/300"}
                alt={story.name}
                className="w-full h-full object-cover"
              />
              {story.isCreate ? (
                <>
                  <div className="absolute bottom-0 left-0 right-0 bg-card p-2 text-center">
                    <div className="absolute -top-5 left-1/2 -translate-x-1/2 w-10 h-10 rounded-full bg-primary flex items-center justify-center border-4 border-card">
                      <Plus className="w-5 h-5 text-primary-foreground" />
                    </div>
                    <p className="text-xs font-semibold mt-2">{story.name}</p>
                  </div>
                </>
              ) : (
                <>
                  <div className="absolute top-2 left-2">
                    <Avatar className="w-10 h-10 border-4 border-primary">
                      <AvatarImage
                        src={
                          "https://picsum.photos/seed/avatar" +
                          story.id +
                          "/100/100"
                        }
                      />
                      <AvatarFallback>{story.name[0]}</AvatarFallback>
                    </Avatar>
                  </div>
                  <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/60 to-transparent p-2">
                    <p className="text-white text-xs font-semibold">
                      {story.name}
                    </p>
                  </div>
                </>
              )}
            </Card>
          </Link>
        ))}
      </div>
    </div>
  );
}
