"use client"

import { useState } from "react"
import { X, Minus, Phone, Video, ImageIcon, Smile, ThumbsUp, Send } from "lucide-react"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Card } from "@/components/ui/card"

interface Message {
  id: number
  text: string
  sender: "me" | "other"
  time: string
}

interface ChatWindowProps {
  name: string
  avatar: string
  online: boolean
  onClose: () => void
  onMinimize: () => void
}

export function ChatWindow({ name, avatar, online, onClose, onMinimize }: ChatWindowProps) {
  const [messages, setMessages] = useState<Message[]>([
    { id: 1, text: "A qua ngủ vs e nhà", sender: "other", time: "14:32" },
    { id: 2, text: "oka nh", sender: "other", time: "14:35" },
    { id: 3, text: "Má ơi", sender: "other", time: "14:38" },
    { id: 4, text: "nói tôi đi", sender: "other", time: "14:40" },
    { id: 5, text: "mà khum vẫn chưa bt", sender: "other", time: "14:42" },
    { id: 6, text: "lô cô dsos rồi", sender: "other", time: "14:45" },
  ])
  const [inputValue, setInputValue] = useState("")

  const handleSend = () => {
    if (inputValue.trim()) {
      setMessages([
        ...messages,
        {
          id: messages.length + 1,
          text: inputValue,
          sender: "me",
          time: new Date().toLocaleTimeString("vi-VN", { hour: "2-digit", minute: "2-digit" }),
        },
      ])
      setInputValue("")
    }
  }

  return (
    <Card className="fixed bottom-0 right-4 w-80 h-[500px] shadow-2xl flex flex-col z-50 overflow-hidden">
      {/* Chat header */}
      <div className="bg-card border-b p-2 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <div className="relative">
            <Avatar className="w-8 h-8">
              <AvatarImage src={avatar || "https://picsum.photos/seed/avatar/100/100"} />
              <AvatarFallback>{name[0]}</AvatarFallback>
            </Avatar>
            {online && (
              <div className="absolute bottom-0 right-0 w-2.5 h-2.5 bg-green-500 rounded-full border-2 border-card" />
            )}
          </div>
          <div>
            <h3 className="font-semibold text-sm">{name}</h3>
            {online && <p className="text-xs text-muted-foreground">Đang hoạt động</p>}
          </div>
        </div>
        <div className="flex items-center gap-1">
          <Button variant="ghost" size="icon" className="h-8 w-8 rounded-full hover:bg-fb-hover text-primary">
            <Phone className="w-4 h-4" />
          </Button>
          <Button variant="ghost" size="icon" className="h-8 w-8 rounded-full hover:bg-fb-hover text-primary">
            <Video className="w-4 h-4" />
          </Button>
          <Button variant="ghost" size="icon" className="h-8 w-8 rounded-full hover:bg-fb-hover" onClick={onMinimize}>
            <Minus className="w-4 h-4" />
          </Button>
          <Button variant="ghost" size="icon" className="h-8 w-8 rounded-full hover:bg-fb-hover" onClick={onClose}>
            <X className="w-4 h-4" />
          </Button>
        </div>
      </div>

      {/* Messages area with gradient background */}
      <div
        className="flex-1 overflow-y-auto p-3 space-y-2"
        style={{
          background: "linear-gradient(135deg, #a8b5ff 0%, #e8b5ff 50%, #ffa8d5 100%)",
        }}
      >
        {messages.map((message) => (
          <div key={message.id} className={`flex ${message.sender === "me" ? "justify-end" : "justify-start"}`}>
            <div
              className={`max-w-[70%] rounded-2xl px-3 py-2 ${
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
      <div className="border-t p-2 bg-card">
        <div className="flex items-center gap-2">
          <Button variant="ghost" size="icon" className="h-8 w-8 rounded-full hover:bg-fb-hover">
            <ImageIcon className="w-4 h-4 text-primary" />
          </Button>
          <Button variant="ghost" size="icon" className="h-8 w-8 rounded-full hover:bg-fb-hover">
            <Smile className="w-4 h-4 text-primary" />
          </Button>
          <Input
            placeholder="Aa"
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && handleSend()}
            className="flex-1 rounded-full border-0 bg-secondary"
          />
          {inputValue.trim() ? (
            <Button variant="ghost" size="icon" className="h-8 w-8 rounded-full hover:bg-fb-hover" onClick={handleSend}>
              <Send className="w-4 h-4 text-primary" />
            </Button>
          ) : (
            <Button variant="ghost" size="icon" className="h-8 w-8 rounded-full hover:bg-fb-hover">
              <ThumbsUp className="w-4 h-4 text-primary" />
            </Button>
          )}
        </div>
      </div>
    </Card>
  )
}

export function MinimizedChat({ name, avatar, onClick }: { name: string; avatar: string; onClick: () => void }) {
  return (
    <Button
      variant="ghost"
      className="fixed bottom-0 right-4 w-60 h-12 bg-card shadow-lg rounded-t-lg hover:bg-fb-hover flex items-center justify-start gap-2 px-3"
      onClick={onClick}
    >
      <Avatar className="w-8 h-8">
        <AvatarImage src={avatar || "https://picsum.photos/seed/avatar/100/100"} />
        <AvatarFallback>{name[0]}</AvatarFallback>
      </Avatar>
      <span className="font-semibold text-sm">{name}</span>
    </Button>
  )
}