"use client";

import { useState } from "react";
import {
  MoreHorizontal,
  ThumbsUp,
  MessageCircle,
  Share2,
  Heart,
  Laugh,
  Frown,
  Angry,
} from "lucide-react";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { ShareModal } from "./ShareModal";

interface PostProps {
  author: string;
  avatar: string;
  time: string;
  content: string;
  image?: string;
  video?: boolean;
  likes: number;
  comments: number;
  shares: number;
}

export function Post({
  author,
  avatar,
  time,
  content,
  image,
  video,
  likes,
  comments,
  shares,
}: PostProps) {
  const [showReactions, setShowReactions] = useState(false);
  const [selectedReaction, setSelectedReaction] = useState<string | null>(null);
  const [showComments, setShowComments] = useState(false);
  const [showShareModal, setShowShareModal] = useState(false);

  const reactions = [
    {
      icon: ThumbsUp,
      label: "Thích",
      color: "text-blue-500",
      bg: "bg-blue-500",
    },
    {
      icon: Heart,
      label: "Yêu thích",
      color: "text-red-500",
      bg: "bg-red-500",
    },
    {
      icon: Laugh,
      label: "Haha",
      color: "text-yellow-500",
      bg: "bg-yellow-500",
    },
    {
      icon: Frown,
      label: "Buồn",
      color: "text-yellow-600",
      bg: "bg-yellow-600",
    },
    {
      icon: Angry,
      label: "Phẫn nộ",
      color: "text-orange-500",
      bg: "bg-orange-500",
    },
  ];

  const dummyComments = [
    {
      id: 1,
      author: "Người dùng 1",
      avatar: "https://picsum.photos/seed/comment1/100/100",
      text: "Bài viết hay quá!",
    },
    {
      id: 2,
      author: "Người dùng 2",
      avatar: "https://picsum.photos/seed/comment2/100/100",
      text: "Cảm ơn bạn đã chia sẻ.",
    },
  ];

  return (
    <Card className="shadow">
      {/* Post header */}
      <div className="pt-4 px-4 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Avatar>
            <AvatarImage
              src={avatar || "https://picsum.photos/seed/avatar/100/100"}
            />
            <AvatarFallback>{author[0]}</AvatarFallback>
          </Avatar>
          <div>
            <h3 className="font-semibold text-sm">{author}</h3>
            <p className="text-xs text-muted-foreground">{time}</p>
          </div>
        </div>
        <Button
          variant="ghost"
          size="icon"
          className="rounded-full hover:bg-fb-hover"
        >
          <MoreHorizontal className="w-5 h-5" />
        </Button>
      </div>

      {/* Post content */}
      <div className="px-4">
        <p className="text-sm">{content}</p>
      </div>

      {/* Post media */}
      {image && (
        <div className="relative">
          <img
            src={image || "https://picsum.photos/600/400"}
            alt="Post"
            className="w-full"
          />
        </div>
      )}
      {video && (
        <div className="relative bg-black aspect-video flex items-center justify-center">
          <div className="text-white">Video Content</div>
        </div>
      )}

      {/* Engagement stats */}
      <div className="px-4 py-2 flex items-center justify-between text-sm text-muted-foreground">
        <div className="flex items-center gap-1">
          <div className="flex -space-x-1">
            <div className="w-5 h-5 rounded-full bg-blue-500 flex items-center justify-center">
              <ThumbsUp className="w-3 h-3 text-white fill-white" />
            </div>
            <div className="w-5 h-5 rounded-full bg-red-500 flex items-center justify-center">
              <Heart className="w-3 h-3 text-white fill-white" />
            </div>
            <div className="w-5 h-5 rounded-full bg-yellow-500 flex items-center justify-center">
              <Laugh className="w-3 h-3 text-white fill-white" />
            </div>
          </div>
          <span>{likes.toLocaleString()}</span>
        </div>
        <div className="flex gap-3">
          <span>{comments} bình luận</span>
          <span>{shares} lượt chia sẻ</span>
        </div>
      </div>

      {/* Action buttons */}
      <div className="border-t mx-4" />
      <div className="px-2 py-1 flex items-center justify-around">
        <div className="relative flex-1">
          <Button
            variant="ghost"
            className={`w-full gap-2 hover:bg-fb-hover ${
              selectedReaction
                ? reactions.find((r) => r.label === selectedReaction)?.color
                : ""
            }`}
            onMouseEnter={() => setShowReactions(true)}
            onMouseLeave={() => setShowReactions(false)}
            onClick={() =>
              setSelectedReaction(selectedReaction ? null : "Thích")
            }
          >
            <ThumbsUp className="w-5 h-5" />
            <span className="font-semibold">{selectedReaction || "Thích"}</span>
          </Button>

          {showReactions && (
            <div
              className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 bg-card rounded-full shadow-lg p-2 flex gap-2"
              onMouseEnter={() => setShowReactions(true)}
              onMouseLeave={() => setShowReactions(false)}
            >
              {reactions.map((reaction) => (
                <button
                  key={reaction.label}
                  className="hover:scale-125 transition-transform"
                  onClick={() => {
                    setSelectedReaction(reaction.label);
                    setShowReactions(false);
                  }}
                >
                  <div
                    className={`w-10 h-10 rounded-full ${reaction.bg} flex items-center justify-center`}
                  >
                    <reaction.icon className="w-6 h-6 text-white fill-white" />
                  </div>
                </button>
              ))}
            </div>
          )}
        </div>

        <Button
          variant="ghost"
          className="flex-1 gap-2 hover:bg-fb-hover"
          onClick={() => setShowComments(!showComments)}
        >
          <MessageCircle className="w-5 h-5" />
          <span className="font-semibold">Bình luận</span>
        </Button>
        <Button
          variant="ghost"
          className="flex-1 gap-2 hover:bg-fb-hover"
          onClick={() => setShowShareModal(true)}
        >
          <Share2 className="w-5 h-5" />
          <span className="font-semibold">Chia sẻ</span>
        </Button>
      </div>

      {/* Comment section */}
      {showComments && (
        <div className="p-4 border-t">
          <div className="flex items-center gap-2 mb-4">
            <Avatar>
              <AvatarImage src="https://picsum.photos/seed/myavatar/100/100" />
              <AvatarFallback>U</AvatarFallback>
            </Avatar>
            <div className="relative flex-1">
              <input
                type="text"
                placeholder="Viết bình luận..."
                className="bg-secondary rounded-full pl-4 pr-10 py-2 w-full focus:outline-none"
              />
            </div>
          </div>
          <div className="space-y-4">
            {dummyComments.map((comment) => (
              <div key={comment.id} className="flex items-start gap-2">
                <Avatar className="w-8 h-8">
                  <AvatarImage src={comment.avatar} />
                  <AvatarFallback>{comment.author[0]}</AvatarFallback>
                </Avatar>
                <div className="bg-secondary rounded-lg p-2">
                  <p className="font-semibold text-sm">{comment.author}</p>
                  <p className="text-sm">{comment.text}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Share modal */}
      {showShareModal && (
        <ShareModal onClose={() => setShowShareModal(false)} />
      )}
    </Card>
  );
}
