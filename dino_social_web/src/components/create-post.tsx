import { ImageIcon, Video, Smile } from "lucide-react"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Button } from "@/components/ui/button"
import { Card } from "@/components/ui/card"

export function CreatePost() {
  return (
    <Card className="p-4 shadow">
      <div className="flex gap-2 mb-3">
        <Avatar>
          <AvatarImage src="https://picsum.photos/seed/myavatar/100/100" />
          <AvatarFallback>QT</AvatarFallback>
        </Avatar>
        <Button
          variant="ghost"
          className="flex-1 justify-start bg-secondary hover:bg-fb-active rounded-full text-muted-foreground"
        >
          Thức ơi, bạn đang nghĩ gì thế?
        </Button>
      </div>
      <div className="border-t pt-2 flex items-center justify-around">
        <Button variant="ghost" className="flex-1 gap-2 hover:bg-fb-hover">
          <Video className="w-6 h-6 text-red-500" />
          <span className="hidden sm:inline font-semibold text-muted-foreground">Video trực tiếp</span>
        </Button>
        <Button variant="ghost" className="flex-1 gap-2 hover:bg-fb-hover">
          <ImageIcon className="w-6 h-6 text-green-500" />
          <span className="hidden sm:inline font-semibold text-muted-foreground">Ảnh/video</span>
        </Button>
        <Button variant="ghost" className="flex-1 gap-2 hover:bg-fb-hover">
          <Smile className="w-6 h-6 text-yellow-500" />
          <span className="hidden sm:inline font-semibold text-muted-foreground">Cảm xúc/hoạt động</span>
        </Button>
      </div>
    </Card>
  )
}