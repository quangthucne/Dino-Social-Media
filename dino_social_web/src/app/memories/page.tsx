import { Sidebar } from "@/components/sidebar";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Clock, Calendar } from "lucide-react";

export default function MemoriesPage() {
  return (
    <div className="min-h-screen bg-background">
      <div className="flex">
        <Sidebar />

        <main className="flex-1 lg:ml-80 p-4">
          <div className="max-w-2xl mx-auto">
            <h1 className="text-2xl font-bold mb-6">Kỷ niệm</h1>

            <Card className="p-8 text-center">
              <Clock className="w-16 h-16 mx-auto mb-4 text-muted-foreground" />
              <h2 className="text-xl font-semibold mb-2">
                Không có kỷ niệm mới
              </h2>
              <p className="text-muted-foreground mb-4">
                Hãy quay lại sau để xem kỷ niệm từ những ngày này trong quá khứ
              </p>
              <Button variant="secondary">
                <Calendar className="w-4 h-4 mr-2" />
                Xem lịch
              </Button>
            </Card>
          </div>
        </main>
      </div>
    </div>
  );
}
