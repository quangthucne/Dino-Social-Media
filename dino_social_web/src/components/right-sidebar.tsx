"use client";

import { useState } from "react";
import { Search, MoreHorizontal, Video } from "lucide-react";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { ChatWindow, MinimizedChat } from "@/components/messenger-chat";

export function RightSidebar() {
  const [openChat, setOpenChat] = useState<{
    name: string;
    avatar: string;
    online: boolean;
  } | null>(null);
  const [minimizedChat, setMinimizedChat] = useState<{
    name: string;
    avatar: string;
  } | null>(null);

  const contacts = [
    {
      id: 1,
      name: "Meta AI",
      avatar: "https://picsum.photos/seed/contact1/100/100",
      online: true,
    },
    {
      id: 2,
      name: "Ví Khiêm",
      avatar: "https://picsum.photos/seed/contact2/100/100",
      online: true,
    },
    {
      id: 3,
      name: "Huyền Trân",
      avatar: "https://picsum.photos/seed/contact3/100/100",
      online: false,
    },
    {
      id: 4,
      name: "Tran Thanh Thanh",
      avatar: "https://picsum.photos/seed/contact4/100/100",
      online: false,
    },
    {
      id: 5,
      name: "Tùng Nek",
      avatar: "https://picsum.photos/seed/contact5/100/100",
      online: true,
    },
    {
      id: 6,
      name: "Duyên Lê",
      avatar: "https://picsum.photos/seed/contact6/100/100",
      online: false,
    },
    {
      id: 7,
      name: "Ngocquy Huynh",
      avatar: "https://picsum.photos/seed/contact7/100/100",
      online: true,
    },
    {
      id: 8,
      name: "Nguyễn Minh Khôi",
      avatar: "https://picsum.photos/seed/contact8/100/100",
      online: false,
    },
  ];

  const handleContactClick = (contact: {
    name: string;
    avatar: string;
    online: boolean;
  }) => {
    setOpenChat(contact);
    setMinimizedChat(null);
  };

  return (
    <>
      <aside className="hidden lg:block w-80 fixed right-0 top-14 h-[calc(100vh-3.5rem)] overflow-y-auto p-4">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-muted-foreground font-semibold">Người liên hệ</h2>
          <div className="flex gap-2">
            <Button
              variant="ghost"
              size="icon"
              className="rounded-full hover:bg-fb-hover"
            >
              <Video className="w-4 h-4" />
            </Button>
            <Button
              variant="ghost"
              size="icon"
              className="rounded-full hover:bg-fb-hover"
            >
              <Search className="w-4 h-4" />
            </Button>
            <Button
              variant="ghost"
              size="icon"
              className="rounded-full hover:bg-fb-hover"
            >
              <MoreHorizontal className="w-4 h-4" />
            </Button>
          </div>
        </div>

        <div className="space-y-1">
          {contacts.map((contact) => (
            <Button
              key={contact.id}
              variant="ghost"
              className="w-full justify-start gap-3 h-12 px-2 hover:bg-fb-hover"
              onClick={() => handleContactClick(contact)}
            >
              <div className="relative">
                <Avatar className="w-9 h-9">
                  <AvatarImage src={contact.avatar || "https://picsum.photos/100/100"} />
                  <AvatarFallback>{contact.name[0]}</AvatarFallback>
                </Avatar>
                {contact.online && (
                  <div className="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border-2 border-card" />
                )}
              </div>
              <span className="font-medium">{contact.name}</span>
            </Button>
          ))}
        </div>
      </aside>

      {openChat && (
        <ChatWindow
          name={openChat.name}
          avatar={openChat.avatar}
          online={openChat.online}
          onClose={() => setOpenChat(null)}
          onMinimize={() => {
            setMinimizedChat({ name: openChat.name, avatar: openChat.avatar });
            setOpenChat(null);
          }}
        />
      )}

      {minimizedChat && !openChat && (
        <MinimizedChat
          name={minimizedChat.name}
          avatar={minimizedChat.avatar}
          onClick={() => {
            setOpenChat({ ...minimizedChat, online: true });
            setMinimizedChat(null);
          }}
        />
      )}
    </>
  );
}