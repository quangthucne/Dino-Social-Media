import { Send, ThumbsUp, Heart, Laugh } from "lucide-react"; // Ví dụ dùng icon từ lucide-react

export default function StoryFooter() {
  return (
    <div className="w-full p-4 flex items-center gap-3">
      {/* Ô nhập tin nhắn */}
      <input
        type="text"
        placeholder="Gửi tin nhắn..."
        className="flex-grow h-12 px-4 rounded-full bg-black/30 text-white placeholder:text-gray-300 border border-white/50 focus:outline-none focus:ring-2 focus:ring-white"
      />

      {/* Các biểu tượng cảm xúc nhanh */}
      <div className="flex items-center gap-3 text-white text-3xl">
        <Heart className="cursor-pointer hover:scale-125 transition-transform" />
        <ThumbsUp className="cursor-pointer hover:scale-125 transition-transform" />
        <Laugh className="cursor-pointer hover:scale-125 transition-transform" />
        <Send className="cursor-pointer hover:scale-125 transition-transform" />
      </div>
    </div>
  );
}
