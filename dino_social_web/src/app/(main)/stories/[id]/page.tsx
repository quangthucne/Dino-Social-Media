"use client";

import { useRouter } from "next/navigation";
import { X, ChevronLeft, ChevronRight } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";

interface Story {
  id: number;
  name: string;
  image: string;
  isCreate?: boolean;
}

// Dummy stories data (should be fetched from an API in a real application)
const allStories: Story[] = [
  { id: 1, name: "Tạo tin", image: "https://picsum.photos/seed/story0/200/300", isCreate: true },
  { id: 2, name: "Vũ Thị Lan Ánh", image: "https://picsum.photos/seed/story1/200/300" },
  { id: 3, name: "Lắc Đầu", image: "https://picsum.photos/seed/story2/200/300" },
  { id: 4, name: "VNPAY", image: "https://picsum.photos/seed/story3/200/300" },
  { id: 5, name: "Thông tin Chính phủ", image: "https://picsum.photos/seed/story4/200/300" },
  { id: 6, name: "Nguyễn Văn A", image: "https://picsum.photos/seed/story5/200/300" },
  { id: 7, name: "Trần Thị B", image: "https://picsum.photos/seed/story6/200/300" },
  { id: 8, name: "Lê Văn C", image: "https://picsum.photos/seed/story7/200/300" },
  { id: 9, name: "Phạm Thị D", image: "https://picsum.photos/seed/story8/200/300" },
  { id: 10, name: "Hoàng Văn E", image: "https://picsum.photos/seed/story9/200/300" },
];

export default function StoryDetailPage({ params }: { params: { id: string } }) {
  const router = useRouter();
  const storyId = parseInt(params.id);

  const stories = allStories.filter(s => !s.isCreate); // Filter out create story for navigation
  const currentStoryIndex = stories.findIndex((story) => story.id === storyId);
  const currentStory = stories[currentStoryIndex];

  const goToNextStory = () => {
    const nextIndex = (currentStoryIndex + 1) % stories.length;
    router.push(`/stories/${stories[nextIndex].id}`);
  };

  const goToPreviousStory = () => {
    const prevIndex = (currentStoryIndex - 1 + stories.length) % stories.length;
    router.push(`/stories/${stories[prevIndex].id}`);
  };

  if (!currentStory) {
    return (
      <div className="fixed inset-0 bg-black z-50 flex items-center justify-center text-white">
        Story not found.
        <Button
          variant="ghost"
          size="icon"
          className="absolute top-4 right-4 text-white hover:bg-white/20"
          onClick={() => router.back()}
        >
          <X className="w-6 h-6" />
        </Button>
      </div>
    );
  }

  return (
    <div className="fixed inset-0 bg-black z-50 flex items-center justify-center">
      <Button
        variant="ghost"
        size="icon"
        className="absolute top-4 right-4 text-white hover:bg-white/20"
        onClick={() => router.back()}
      >
        <X className="w-6 h-6" />
      </Button>

      <div className="relative w-full max-w-md h-full max-h-[90vh] flex flex-col">
        <div className="flex items-center justify-between p-2">
          <div className="flex items-center gap-2">
            <Avatar className="w-8 h-8">
              <AvatarImage src={currentStory.image} />
              <AvatarFallback>{currentStory.name[0]}</AvatarFallback>
            </Avatar>
            <span className="text-white font-semibold">{currentStory.name}</span>
          </div>
        </div>

        <div className="flex-1 relative flex items-center justify-center">
          <img
            src={currentStory.image}
            alt={currentStory.name}
            className="max-w-full max-h-full object-contain"
          />

          <Button
            variant="ghost"
            size="icon"
            className="absolute left-2 top-1/2 -translate-y-1/2 text-white hover:bg-white/20"
            onClick={goToPreviousStory}
          >
            <ChevronLeft className="w-8 h-8" />
          </Button>
          <Button
            variant="ghost"
            size="icon"
            className="absolute right-2 top-1/2 -translate-y-1/2 text-white hover:bg-white/20"
            onClick={goToNextStory}
          >
            <ChevronRight className="w-8 h-8" />
          </Button>
        </div>
      </div>
    </div>
  );
}
