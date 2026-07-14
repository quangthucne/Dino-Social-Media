"use client";

import { useState } from "react";
import {
  Search,
  MoreHorizontal,
  Video,
  Phone,
  Info,
  ImageIcon,
  Smile,
  ThumbsUp,
  Send,
  Edit,
} from "lucide-react";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

export default function MessengerPage() {
  const [selectedChat, setSelectedChat] = useState(0);
  const [inputValue, setInputValue] = useState("");

  const conversations = [
    {
      id: 1,
      name: "Hội Trà Lai Hoàng Phát",
      avatar: "https://picsum.photos/seed/messenger1/100/100",
      lastMessage: "lô cô dsos rồi",
      time: "6 giờ",
      unread: false,
    },
    {
      id: 2,
      name: "Vũ Thái",
      avatar: "https://picsum.photos/seed/messenger2/100/100",
      lastMessage: "tự giận ổ nhà kida ba",
      time: "10 giờ",
      unread: false,
    },
    {
      id: 3,
      name: "Hội Đông Bo",
      avatar: "https://picsum.photos/seed/messenger3/100/100",
      lastMessage: "Thôi tôi dành cho các...",
      time: "1 ngày",
      unread: true,
    },
    {
      id: 4,
      name: "Hà Trần",
      avatar: "https://picsum.photos/seed/messenger4/100/100",
      lastMessage: "Hà đã gửi một nhắn dán",
      time: "2 ngày",
      unread: false,
    },
  ];

  const messages = [
    { id: 1, text: "A qua ngủ vs e nhà", sender: "other", time: "14:32" },
    { id: 2, text: "oka nh", sender: "other", time: "14:35" },
    { id: 3, text: "Má ơi", sender: "other", time: "14:38" },
    { id: 4, text: "nói tôi đi", sender: "other", time: "14:40" },
    { id: 5, text: "mà khum vẫn chưa bt", sender: "other", time: "14:42" },
    { id: 6, text: "lô cô dsos rồi", sender: "other", time: "14:45" },
  ];

  const handleSend = () => {
    if (inputValue.trim()) {
      setInputValue("");
    }
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="flex h-screen">
        {/* Conversations list */}
        <div className="w-80 border-r bg-card flex flex-col">
          <div className="p-4 border-b">
            <div className="flex items-center justify-between mb-4">
              <h1 className="text-2xl font-bold">Đoạn chat</h1>
              <div className="flex gap-2">
                <Button
                  variant="ghost"
                  size="icon"
                  className="rounded-full hover:bg-fb-hover"
                >
                  <MoreHorizontal className="w-5 h-5" />
                </Button>
                <Button
                  variant="ghost"
                  size="icon"
                  className="rounded-full hover:bg-fb-hover"
                >
                  <Edit className="w-5 h-5" />
                </Button>
              </div>
            </div>
            <div className="relative">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <Input
                placeholder="Tìm kiếm trên Messenger"
                className="pl-10 bg-secondary border-0 rounded-full"
              />
            </div>
          </div>

          <div className="flex gap-2 px-4 py-2 border-b">
            <Button
              variant="ghost"
              className="rounded-full bg-primary text-primary-foreground hover:bg-primary/90"
            >
              Tất cả
            </Button>
            <Button variant="ghost" className="rounded-full hover:bg-fb-hover">
              Chưa đọc
            </Button>
            <Button variant="ghost" className="rounded-full hover:bg-fb-hover">
              Nhóm
            </Button>
          </div>

          <div className="flex-1 overflow-y-auto">
            {conversations.map((conv, index) => (
              <Button
                key={conv.id}
                variant="ghost"
                className={`w-full justify-start gap-3 h-20 px-4 rounded-none ${
                  selectedChat === index ? "bg-fb-hover" : ""
                }`}
                onClick={() => setSelectedChat(index)}
              >
                <Avatar className="w-14 h-14">
                  <AvatarImage src={conv.avatar || "https://picsum.photos/100/100"} />
                  <AvatarFallback>{conv.name[0]}</AvatarFallback>
                </Avatar>
                <div className="flex-1 text-left">
                  <div className="flex items-center justify-between">
                    <h3 className="font-semibold text-sm">{conv.name}</h3>
                    <span className="text-xs text-muted-foreground">
                      {conv.time}
                    </span>
                  </div>
                  <p
                    className={`text-sm ${
                      conv.unread ? "font-semibold" : "text-muted-foreground"
                    }`}
                  >
                    {conv.lastMessage}
                  </p>
                </div>
                {conv.unread && (
                  <div className="w-3 h-3 bg-primary rounded-full" />
                )}
              </Button>
            ))}
          </div>
        </div>

        {/* Chat area */}
        <div className="flex-1 flex flex-col">
          {/* Chat header */}
          <div className="bg-card border-b p-3 flex items-center justify-between">
            <div className="flex items-center gap-3">
              <Avatar className="w-10 h-10">
                <AvatarImage
                  src={conversations[selectedChat].avatar || "https://picsum.photos/100/100"}
                />
                <AvatarFallback>
                  {conversations[selectedChat].name[0]}
                </AvatarFallback>
              </Avatar>
              <div>
                <h3 className="font-semibold">
                  {conversations[selectedChat].name}
                </h3>
                <p className="text-xs text-muted-foreground">Đang hoạt động</p>
              </div>
            </div>
            <div className="flex items-center gap-2">
              <Button
                variant="ghost"
                size="icon"
                className="rounded-full hover:bg-fb-hover text-primary"
              >
                <Phone className="w-5 h-5" />
              </Button>
              <Button
                variant="ghost"
                size="icon"
                className="rounded-full hover:bg-fb-hover text-primary"
              >
                <Video className="w-5 h-5" />
              </Button>
              <Button
                variant="ghost"
                size="icon"
                className="rounded-full hover:bg-fb-hover text-primary"
              >
                <Info className="w-5 h-5" />
              </Button>
            </div>
          </div>

          {/* Messages area with gradient background */}
          <div
            className="flex-1 overflow-y-auto p-4 space-y-2"
            style={{
              background:
                "linear-gradient(135deg, #a8b5ff 0%, #e8b5ff 50%, #ffa8d5 100%)",
            }}
          >
            <div className="flex justify-center mb-4">
              <Avatar className="w-20 h-20">
                <AvatarImage
                  src={conversations[selectedChat].avatar || "https://picsum.photos/100/100"}
                />
                <AvatarFallback>
                  {conversations[selectedChat].name[0]}
                </AvatarFallback>
              </Avatar>
            </div>
            <h3 className="text-center font-semibold text-lg">
              {conversations[selectedChat].name}
            </h3>
            <p className="text-center text-sm text-muted-foreground mb-6">
              Các bạn là bạn bè trên Facebook • Đang hoạt động
            </p>

            {messages.map((message) => (
              <div
                key={message.id}
                className={`flex ${
                  message.sender === "me" ? "justify-end" : "justify-start"
                }`}
              >
                <div
                  className={`max-w-[60%] rounded-2xl px-4 py-2 ${
                    message.sender === "me"
                      ? "bg-primary text-primary-foreground"
                      : "bg-card text-card-foreground shadow-sm"
                  }`}
                >
                  <p className="text-sm">{message.text}</p>
                </div>
              </div>
            ))}
          </div>

          {/* Input area */}
          <div className="border-t p-3 bg-card">
            <div className="flex items-center gap-2">
              <Button
                variant="ghost"
                size="icon"
                className="rounded-full hover:bg-fb-hover"
              >
                <ImageIcon className="w-5 h-5 text-primary" />
              </Button>
              <Button
                variant="ghost"
                size="icon"
                className="rounded-full hover:bg-fb-hover"
              >
                <Smile className="w-5 h-5 text-primary" />
              </Button>
              <Input
                placeholder="Aa"
                value={inputValue}
                onChange={(e) => setInputValue(e.target.value)}
                onKeyDown={(e) => e.key === "Enter" && handleSend()}
                className="flex-1 rounded-full border-0 bg-secondary"
              />
              {inputValue.trim() ? (
                <Button
                  variant="ghost"
                  size="icon"
                  className="rounded-full hover:bg-fb-hover"
                  onClick={handleSend}
                >
                  <Send className="w-5 h-5 text-primary" />
                </Button>
              ) : (
                <Button
                  variant="ghost"
                  size="icon"
                  className="rounded-full hover:bg-fb-hover"
                >
                  <ThumbsUp className="w-5 h-5 text-primary" />
                </Button>
              )}
            </div>
          </div>
        </div>

        {/* Right sidebar - Chat info */}
        <div className="hidden xl:block w-80 border-l bg-card p-4">
          <div className="flex flex-col items-center">
            <Avatar className="w-24 h-24 mb-3">
              <AvatarImage
                src={conversations[selectedChat].avatar || "https://picsum.photos/100/100"}
              />
              <AvatarFallback>
                {conversations[selectedChat].name[0]}
              </AvatarFallback>
            </Avatar>
            <h3 className="font-semibold text-lg">
              {conversations[selectedChat].name}
            </h3>
            <p className="text-sm text-muted-foreground mb-4">Đang hoạt động</p>

            <div className="w-full space-y-2">
              <Button
                variant="ghost"
                className="w-full justify-start gap-2 hover:bg-fb-hover"
              >
                <div className="w-8 h-8 rounded-full bg-secondary flex items-center justify-center">
                  <Info className="w-4 h-4" />
                </div>
                <span className="font-medium">Thông tin về đoạn chat</span>
              </Button>
              <Button
                variant="ghost"
                className="w-full justify-start gap-2 hover:bg-fb-hover"
              >
                <div className="w-8 h-8 rounded-full bg-secondary flex items-center justify-center">
                  <Search className="w-4 h-4" />
                </div>
                <span className="font-medium">Tìm kiếm</span>
              </Button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}