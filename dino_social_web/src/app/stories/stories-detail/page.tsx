"use client";
import { Button } from "@/components/ui/button";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"; // Correct import
import { faXmark } from "@fortawesome/free-solid-svg-icons"; // Import the specific icon
import {
  Plus,
  ArrowLeftCircle,
  ArrowLeft,
  ArrowLeftSquare,
  ChevronLeft,
  ChevronRight,
} from "lucide-react";
import Link from "next/link";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import StoriesDetail from "@/components/stories-detail";
import { Input } from "@/components/ui/input";
import StoryFooter from "@/components/stories-footer";

export default function StoriesDetailPage() {
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
  return (
    <div className="flex">
      {/* Left sidebar */}
      <div className="w-1/4 h-[100vh] bg-[#ffffff] rounded-lg">
        <div className="flex-row h-15 border-b">
          <div className="flex-row display-flex align-item-center p-4">
            <Link href={"/"}>
              <Button
                variant="ghost"
                size="icon"
                className="rounded-full bg-[#919191] hover:bg-fb-active justify-center items-center"
              >
                <span className="text-lg font-bold text-white">
                  <FontAwesomeIcon icon={faXmark} />
                </span>
              </Button>
            </Link>
          </div>
        </div>
        <div className="flex-row h-[calc(100vh-60px)] overflow-y-scroll">
          <div className="flex-row p-4">
            <h1 className="text-[1.8rem] font-bold text-dark">Tin</h1>
          </div>
          <div className="flex-row p-4">
            <Link href="#" className="px-2">
              <span className="text-[blue] text-sm">Kho lưu trữ</span>
            </Link>

            <Link href="#" className="px-2">
              <span className="text-[blue] text-sm">Cài đặt</span>
            </Link>
          </div>
          <div className="flex-row p-4 ">
            <h3 className="font-bold text-lg">Tin của bạn</h3>
          </div>
          <div
            className="flex-row pl-4 pr-4 flex gap-2 cursor-pointer"
            onClick={() => {
              console.log("click");
            }}
          >
            <div className="w-1/4">
              <div className="size-15 rounded-full  bg-[#F1F2F5] justify-center items-center flex">
                <Plus className="text-primary" />
              </div>
            </div>
            <div className="w-3/4">
              <div className="text-lg">
                <h4 className="font-bold">Tạo tin</h4>
                <span className="text-[#65686C] text-[0.9rem]">
                  Bạn có thể chia sẻ anh hoặc viết gì đó
                </span>
              </div>
            </div>
          </div>

          <div className="flex-row p-4 ">
            <h3 className="font-bold text-lg">Tất cả tin</h3>
          </div>
          <div className="flex-row pl-4 pr-4 flex gap-2 cursor-pointer">
            <div className="space-y-1">
              {contacts.map((contact) => (
                <Button
                  key={contact.id}
                  variant="ghost"
                  className="w-full justify-start gap-3 h-20 px-2 hover:bg-fb-hover"
                  onClick={() => {}}
                >
                  <div className="relative">
                    <Avatar className="size-15 border-4 border-primary">
                      <AvatarImage
                        src={contact.avatar || "https://picsum.photos/100/100"}
                      />
                      <AvatarFallback>{contact.name[0]}</AvatarFallback>
                    </Avatar>
                    {contact.online && (
                      <div className="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border-2 border-card" />
                    )}
                  </div>
                  <span className="font-bold text-[1.0rem]">
                    {contact.name}
                  </span>
                </Button>
              ))}
            </div>
          </div>
        </div>
      </div>
      {/* Main content area */}
      <div className="w-3/4 h-[100vh] bg-[#000000] rounded-lg">
        <div className="flex h-[90%] items-center">
          <div className="w-1/3 h-full  items-center flex justify-end gap-2">
            <div
              className="flex justify-center items-center size-10 rounded-full bg-[#f1f2f5] cursor-pointer"
              onClick={() => {}}
            >
              <ChevronLeft className="text-[#65686C]" />
            </div>
          </div>
          <div className="w-1/3 h-full gap-2">
            <StoriesDetail />
          </div>
          <div className="w-1/3 h-full  items-center flex justify-start gap-2">
            <div
              className="flex justify-center items-center size-10 rounded-full bg-[#f1f2f5] cursor-pointer"
              onClick={() => {}}
            >
              <ChevronRight className="text-[#65686C]" />
            </div>
          </div>
        </div>
        <div className="flex-row h-[10%]">
          <div className="flex justify-center items-center">
            <div className="w-2/4">
              <StoryFooter />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
