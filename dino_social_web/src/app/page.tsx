import { Header } from "@/components/header";
import { Sidebar } from "@/components/sidebar";
import { NewsFeed } from "@/components/news-feed";
import { RightSidebar } from "@/components/right-sidebar";

export default function Home() {
  return (
    <div className="min-h-screen bg-background">
      <Header />
      <div className="flex pt-14">
        <Sidebar />
        <NewsFeed />
        <RightSidebar />
      </div>
    </div>
  );
}
