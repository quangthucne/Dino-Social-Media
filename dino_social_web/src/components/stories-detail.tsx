import Stories from "react-insta-stories";

export default function StoriesDetail() {
  const stories = [
    {
      url: "https://scontent.fvca1-4.fna.fbcdn.net/v/t39.30808-6/564104020_1385538529595203_5564437861425878541_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=1&ccb=1-7&_nc_sid=833d8c&_nc_ohc=ngS_aWT_9BcQ7kNvwE4_v5R&_nc_oc=AdmzjuHlddj2nsaKKA3CSf3bmVhb9j9WtmNtldfJHyv_ubUOqi_crXkmHEc9wtgFa0R02pNkD2trVVqdgt9P6dBq&_nc_zt=23&_nc_ht=scontent.fvca1-4.fna&_nc_gid=TVJWPAmkINUmdnDBRRApdQ&oh=00_AfcyWlDXUW27u_C7HdRXEu2aMXI_REuhMP1pFNJ87RzMCA&oe=68F3EA69",
      header: {
        heading: "Double2T - Người Miền Núi Chất",
        subheading: "Đăng 4 giờ trước",
        profileImage: "https://example.com/avatar.jpg",
      },
    },
    {
      url: "https://example.com/image2.jpg",
      header: {
        heading: "Double2T - Người Miền Núi Chất",
        subheading: "Đăng 2 giờ trước",
        profileImage: "https://example.com/avatar.jpg",
      },
    },
    // Thêm các stories khác ở đây
  ];

  return (
    <div className="flex justify-center h-screen bg-black">
      <Stories
        stories={stories}
        defaultInterval={5000} // Thời gian mỗi story (5 giây)
        width={"100%"}
        height={"90%"}
      />
    </div>
  );
}
