import { Sidebar } from "@/components/sidebar";
import { NewsFeed } from "@/components/news-feed";
import { RightSidebar } from "@/components/right-sidebar";

export default function Home() {
  return (
    <div className="flex">
      <Sidebar />
      <NewsFeed />
      <RightSidebar />
    </div>
  );
}
