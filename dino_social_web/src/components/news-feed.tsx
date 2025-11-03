import { CreatePost } from "@/components/create-post";
import { Stories } from "@/components/stories";
import { Post } from "@/components/post";

export function NewsFeed() {
  const posts = [
    {
      id: 1,
      author: "Cao Đẳng FPT Polytechnic Hà Nội",
      avatar: "https://picsum.photos/seed/avatar1/100/100",
      time: "1 giờ",
      content: "Bài viết của Cao đẳng FPT Polytechnic Hà Nội",
      image: "https://picsum.photos/seed/post1/600/400",
      likes: 289,
      comments: 35,
      shares: 2,
    },
    {
      id: 2,
      author: "Lan Hương",
      avatar: "https://picsum.photos/seed/avatar2/100/100",
      time: "Hôm qua lúc 14:03",
      content: "Cách chụp ảnh đọc đôi ảnh nền điện thoại...",
      video: true,
      likes: 10000,
      comments: 77,
      shares: 1500,
    },
    {
      id: 3,
      author: "CNTT - Hỗ trợ code, nhận làm bài tập IT",
      avatar: "https://picsum.photos/seed/avatar3/100/100",
      time: "1 giờ",
      content:
        "Mình cần người giúp làm bài build agent AI để xử lí imbalanced datasets for classification (code python) a",
      likes: 2,
      comments: 2,
      shares: 0,
    },
  ];

  return (
    <main className="flex-1 lg:ml-80 lg:mr-80 mx-auto overflow-y-auto p-5 jsutify-center">
      <div className="flex-1 max-w-[80%] jsutify-center mx-auto">
        <Stories />
        <CreatePost />
        <div className="space-y-4 mt-4">
          {posts.map((post) => (
            <Post key={post.id} {...post} />
          ))}
        </div>
      </div>
    </main>
  );
}