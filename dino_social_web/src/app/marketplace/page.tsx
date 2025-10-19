import { Header } from "@/components/header";
import { Sidebar } from "@/components/sidebar";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Search, MapPin, SlidersHorizontal } from "lucide-react";

export default function MarketplacePage() {
  const items = [
    {
      id: 1,
      title: "iPhone 15 Pro Max 256GB",
      price: "25.000.000đ",
      location: "Hà Nội",
      image: "https://picsum.photos/seed/marketplace1/400/400",
    },
    {
      id: 2,
      title: "Laptop Dell XPS 13",
      price: "18.500.000đ",
      location: "TP. Hồ Chí Minh",
      image: "https://picsum.photos/seed/marketplace2/400/400",
    },
    {
      id: 3,
      title: "Xe máy Honda SH 2023",
      price: "95.000.000đ",
      location: "Đà Nẵng",
      image: "https://picsum.photos/seed/marketplace3/400/400",
    },
    {
      id: 4,
      title: "Tủ lạnh Samsung Inverter",
      price: "12.000.000đ",
      location: "Hà Nội",
      image: "https://picsum.photos/seed/marketplace4/400/400",
    },
    {
      id: 5,
      title: "Ghế gaming DXRacer",
      price: "5.500.000đ",
      location: "Hà Nội",
      image: "https://picsum.photos/seed/marketplace5/400/400",
    },
    {
      id: 6,
      title: "Máy ảnh Canon EOS R6",
      price: "42.000.000đ",
      location: "TP. Hồ Chí Minh",
      image: "https://picsum.photos/seed/marketplace6/400/400",
    },
  ];

  const categories = [
    "Xe cộ",
    "Đồ điện tử",
    "Nhà cửa",
    "Thú cưng",
    "Thời trang",
    "Đồ gia dụng",
    "Giải trí",
    "Gia đình",
  ];

  return (
    <div className="min-h-screen bg-background">
      <Header />
      <div className="flex pt-14">
        <Sidebar />

        <main className="flex-1 lg:ml-80 p-4">
          <div className="max-w-7xl mx-auto">
            <div className="mb-6">
              <h1 className="text-2xl font-bold mb-4">Marketplace</h1>

              <div className="flex gap-3 mb-4">
                <div className="relative flex-1 max-w-md">
                  <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                  <Input
                    placeholder="Tìm kiếm trên Marketplace"
                    className="pl-10 bg-secondary border-0 rounded-lg"
                  />
                </div>
                <Button variant="secondary" className="rounded-lg">
                  <MapPin className="w-4 h-4 mr-2" />
                  Hà Nội
                </Button>
                <Button variant="secondary" className="rounded-lg">
                  <SlidersHorizontal className="w-4 h-4 mr-2" />
                  Bộ lọc
                </Button>
              </div>

              <div className="flex gap-2 overflow-x-auto pb-2">
                <Button
                  variant="secondary"
                  className="rounded-lg whitespace-nowrap"
                >
                  Duyệt tất cả
                </Button>
                {categories.map((category) => (
                  <Button
                    key={category}
                    variant="ghost"
                    className="rounded-lg whitespace-nowrap"
                  >
                    {category}
                  </Button>
                ))}
              </div>
            </div>

            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
              {items.map((item) => (
                <Card
                  key={item.id}
                  className="overflow-hidden cursor-pointer hover:shadow-lg transition-shadow"
                >
                  <img
                    src={item.image || "https://picsum.photos/400/400"}
                    alt={item.title}
                    className="w-full aspect-square object-cover"
                  />
                  <div className="p-3">
                    <p className="font-bold text-lg mb-1">{item.price}</p>
                    <p className="text-sm mb-2 line-clamp-2">{item.title}</p>
                    <p className="text-xs text-muted-foreground flex items-center">
                      <MapPin className="w-3 h-3 mr-1" />
                      {item.location}
                    </p>
                  </div>
                </Card>
              ))}
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}