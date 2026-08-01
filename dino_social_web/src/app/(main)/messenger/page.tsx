"use client";

import { useEffect, useState, useRef } from "react";
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
import { axiosInstance } from "@/utils/axiosIntance";

interface Participant {
  userId: string;
  username: string;
  fullName: string | null;
  avatarUrl: string | null;
}

interface Conversation {
  id: string;
  name: string;
  avatarUrl: string | null;
  lastMessage: string | null;
  lastUpdated: string;
  participants: Participant[];
}

interface Message {
  id: string;
  conversationId: string;
  senderId: string;
  senderName: string;
  senderAvatar: string | null;
  content: string;
  sentAt: string;
  isRead: boolean;
}

export default function MessengerPage() {
  const [conversations, setConversations] = useState<Conversation[]>([]);
  const [selectedConvId, setSelectedConvId] = useState<string | null>(null);
  const [messages, setMessages] = useState<Message[]>([]);
  const [inputValue, setInputValue] = useState("");
  const [myUserId, setMyUserId] = useState<string | null>(null);
  const messagesEndRef = useRef<HTMLDivElement | null>(null);

  // Fetch current user and conversations on mount
  useEffect(() => {
    const initData = async () => {
      try {
        // Fetch current user profile
        const userRes = await axiosInstance.get("/users/me");
        if (userRes.data?.data?.id) {
          setMyUserId(userRes.data.data.id);
        }

        // Fetch conversations
        const convsRes = await axiosInstance.get("/messages/conversations");
        const convList = convsRes.data?.data || [];
        setConversations(convList);
        if (convList.length > 0) {
          setSelectedConvId(convList[0].id);
        }
      } catch (error) {
        console.error("Lỗi khi tải thông tin hội thoại:", error);
      }
    };
    initData();
  }, []);

  // Fetch messages when conversation selection changes
  useEffect(() => {
    if (!selectedConvId) return;

    const fetchMessages = async () => {
      try {
        const msgsRes = await axiosInstance.get(`/messages/conversations/${selectedConvId}`);
        setMessages(msgsRes.data?.data || []);
      } catch (error) {
        console.error("Lỗi khi tải tin nhắn:", error);
      }
    };

    fetchMessages();

    // Auto polling every 3 seconds for new messages
    const interval = setInterval(fetchMessages, 3000);
    return () => clearInterval(interval);
  }, [selectedConvId]);

  // Scroll to bottom when messages list changes
  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  const handleSend = async () => {
    if (!selectedConvId || !inputValue.trim()) return;

    const contentToSend = inputValue.trim();
    setInputValue("");

    try {
      const sendRes = await axiosInstance.post("/messages/send", {
        conversationId: selectedConvId,
        content: contentToSend,
      });

      if (sendRes.data?.data) {
        const newMsg: Message = sendRes.data.data;
        setMessages((prev) => [...prev, newMsg]);

        // Update last message in local conversations list
        setConversations((prev) =>
          prev.map((c) =>
            c.id === selectedConvId
              ? { ...c, lastMessage: contentToSend, lastUpdated: new Date().toISOString() }
              : c
          )
        );
      }
    } catch (error) {
      console.error("Lỗi khi gửi tin nhắn:", error);
    }
  };

  const selectedConv = conversations.find((c) => c.id === selectedConvId);

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
            {conversations.map((conv) => (
              <Button
                key={conv.id}
                variant="ghost"
                className={`w-full justify-start gap-3 h-20 px-4 rounded-none ${
                  selectedConvId === conv.id ? "bg-fb-hover" : ""
                }`}
                onClick={() => setSelectedConvId(conv.id)}
              >
                <Avatar className="w-14 h-14">
                  <AvatarImage src={conv.avatarUrl || "https://picsum.photos/100/100"} />
                  <AvatarFallback>{conv.name[0] || "D"}</AvatarFallback>
                </Avatar>
                <div className="flex-1 text-left">
                  <div className="flex items-center justify-between">
                    <h3 className="font-semibold text-sm truncate max-w-[120px]">{conv.name}</h3>
                    <span className="text-xs text-muted-foreground">
                      {conv.lastUpdated ? new Date(conv.lastUpdated).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : ""}
                    </span>
                  </div>
                  <p className="text-sm text-muted-foreground truncate max-w-[150px]">
                    {conv.lastMessage || "Chưa có tin nhắn"}
                  </p>
                </div>
              </Button>
            ))}
          </div>
        </div>

        {/* Chat area */}
        <div className="flex-1 flex flex-col">
          {selectedConv ? (
            <>
              {/* Chat header */}
              <div className="bg-card border-b p-3 flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <Avatar className="w-10 h-10">
                    <AvatarImage
                      src={selectedConv.avatarUrl || "https://picsum.photos/100/100"}
                    />
                    <AvatarFallback>
                      {selectedConv.name[0] || "D"}
                    </AvatarFallback>
                  </Avatar>
                  <div>
                    <h3 className="font-semibold">
                      {selectedConv.name}
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
                className="flex-1 overflow-y-auto p-4 space-y-3"
                style={{
                  background:
                    "linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%)",
                }}
              >
                <div className="flex justify-center mb-4">
                  <Avatar className="w-20 h-20">
                    <AvatarImage
                      src={selectedConv.avatarUrl || "https://picsum.photos/100/100"}
                    />
                    <AvatarFallback>
                      {selectedConv.name[0] || "D"}
                    </AvatarFallback>
                  </Avatar>
                </div>
                <h3 className="text-center font-semibold text-lg">
                  {selectedConv.name}
                </h3>
                <p className="text-center text-sm text-muted-foreground mb-6">
                  Các bạn đã kết nối trên Dino Social App
                </p>

                {messages.map((message) => (
                  <div
                    key={message.id}
                    className={`flex ${
                      message.senderId === myUserId ? "justify-end" : "justify-start"
                    }`}
                  >
                    <div
                      className={`max-w-[60%] rounded-2xl px-4 py-2 ${
                        message.senderId === myUserId
                          ? "bg-primary text-primary-foreground"
                          : "bg-card text-card-foreground shadow-sm"
                      }`}
                    >
                      <p className="text-sm">{message.content}</p>
                    </div>
                  </div>
                ))}
                <div ref={messagesEndRef} />
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
            </>
          ) : (
            <div className="flex-1 flex items-center justify-center bg-secondary/30">
              <p className="text-muted-foreground">Chọn một đoạn chat để bắt đầu</p>
            </div>
          )}
        </div>

        {/* Right sidebar - Chat info */}
        {selectedConv && (
          <div className="hidden xl:block w-80 border-l bg-card p-4">
            <div className="flex flex-col items-center">
              <Avatar className="w-24 h-24 mb-3">
                <AvatarImage
                  src={selectedConv.avatarUrl || "https://picsum.photos/100/100"}
                />
                <AvatarFallback>
                  {selectedConv.name[0] || "D"}
                </AvatarFallback>
              </Avatar>
              <h3 className="font-semibold text-lg text-center">
                {selectedConv.name}
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
                  <span className="font-medium">Tìm kiếm tin nhắn</span>
                </Button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}