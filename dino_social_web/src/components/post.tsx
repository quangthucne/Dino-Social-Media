"use client";

import { useState } from "react";
import {
	MoreHorizontal,
	ThumbsUp,
	MessageCircle,
	Share2,
	Heart,
	Play,
	Send
} from "lucide-react";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { ShareModal } from "./ShareModal";

interface PostProps {
	author: string;
	avatar: string;
	time: string;
	content: string;
	image?: string;
	video?: boolean;
	likes: number;
	comments: number;
	shares: number;
}

export function Post({
	author,
	avatar,
	time,
	content,
	image,
	video,
	likes,
	comments,
	shares,
}: PostProps) {
	const [showReactions, setShowReactions] = useState(false);
	const [selectedReaction, setSelectedReaction] = useState<string | null>(null);
	const [showComments, setShowComments] = useState(false);
	const [showShareModal, setShowShareModal] = useState(false);

	const [likeCount, setLikeCount] = useState(likes);
	const [commentCount, setCommentCount] = useState(comments);
	const [newCommentText, setNewCommentText] = useState("");

	const reactions = [
		{
			emoji: "👍",
			label: "Thích",
			color: "text-blue-500",
		},
		{
			emoji: "❤️",
			label: "Yêu thích",
			color: "text-red-500",
		},
		{
			emoji: "😆",
			label: "Haha",
			color: "text-yellow-500",
		},
		{
			emoji: "😢",
			label: "Buồn",
			color: "text-yellow-600",
		},
		{
			emoji: "😡",
			label: "Phẫn nộ",
			color: "text-orange-500",
		},
	];

	const [commentsList, setCommentsList] = useState([
		{
			id: 1,
			author: "Người dùng 1",
			avatar: "https://picsum.photos/seed/comment1/100/100",
			text: "Bài viết hay quá!",
		},
		{
			id: 2,
			author: "Người dùng 2",
			avatar: "https://picsum.photos/seed/comment2/100/100",
			text: "Cảm ơn bạn đã chia sẻ.",
		},
	]);

	const handleLikeClick = () => {
		if (selectedReaction) {
			setSelectedReaction(null);
			setLikeCount((prev) => prev - 1);
		} else {
			setSelectedReaction("Thích");
			setLikeCount((prev) => prev + 1);
		}
	};

	const handleSelectReaction = (label: string) => {
		if (!selectedReaction) {
			setLikeCount((prev) => prev + 1);
		}
		setSelectedReaction(label);
		setShowReactions(false);
	};

	const handleAddComment = (e?: React.FormEvent) => {
		if (e) e.preventDefault();
		if (!newCommentText.trim()) return;

		const newComment = {
			id: Date.now(),
			author: "Bạn",
			avatar: "https://picsum.photos/seed/myavatar/100/100",
			text: newCommentText.trim(),
		};

		setCommentsList((prev) => [newComment, ...prev]);
		setNewCommentText("");
		setCommentCount((prev) => prev + 1);
	};

	return (
		<Card className="border border-slate-100 dark:border-zinc-800 shadow-sm rounded-xl overflow-hidden bg-card hover:shadow-md transition-all duration-300">
			{/* Post header */}
			<div className="pt-4 px-4 pb-3 flex items-center justify-between">
				<div className="flex items-center gap-2">
					<Avatar>
						<AvatarImage
							src={
								avatar ||
								"https://picsum.photos/seed/avatar/100/100"
							}
						/>
						<AvatarFallback>{author[0]}</AvatarFallback>
					</Avatar>
					<div>
						<h3 className="font-semibold text-sm">{author}</h3>
						<p className="text-xs text-muted-foreground">{time}</p>
					</div>
				</div>
				<Button
					variant="ghost"
					size="icon"
					className="rounded-full hover:bg-slate-100 dark:hover:bg-zinc-800/80"
				>
					<MoreHorizontal className="w-5 h-5" />
				</Button>
			</div>

			{/* Post content */}
			<div className="px-4 pb-3">
				<p className="text-[15px] text-foreground/90 leading-relaxed font-normal">{content}</p>
			</div>

			{/* Post media */}
			{image && !video && (
				<div className="mx-4 mb-3 overflow-hidden rounded-xl border border-slate-100 dark:border-zinc-800 bg-muted">
					<img
						src={image || "https://picsum.photos/600/400"}
						alt="Post"
						className="w-full h-auto object-cover max-h-[500px]"
					/>
				</div>
			)}
			{video && (
				<div className="mx-4 mb-3 overflow-hidden rounded-xl border border-slate-100 dark:border-zinc-800 bg-black aspect-video flex items-center justify-center relative group cursor-pointer">
					<div
						className="absolute inset-0 bg-cover bg-center opacity-60 filter blur-sm"
						style={{
							backgroundImage: `url(${
								image || "https://picsum.photos/600/400"
							})`,
						}}
					/>
					<div className="relative z-10 w-16 h-16 rounded-full bg-white/20 backdrop-blur-md flex items-center justify-center border border-white/30 group-hover:scale-110 transition-transform duration-300 shadow-lg">
						<Play className="w-8 h-8 text-white fill-white ml-1" />
					</div>
				</div>
			)}

			{/* Engagement stats */}
			<div className="px-4 py-2 flex items-center justify-between text-sm text-muted-foreground">
				<div className="flex items-center gap-1.5">
					<div className="flex -space-x-1">
						<div className="w-5 h-5 rounded-full bg-blue-500 flex items-center justify-center border border-card">
							<ThumbsUp className="w-3 h-3 text-white fill-white" />
						</div>
						<div className="w-5 h-5 rounded-full bg-red-500 flex items-center justify-center border border-card">
							<Heart className="w-3 h-3 text-white fill-white" />
						</div>
					</div>
					<span className="font-medium text-foreground/70">
						{likeCount.toLocaleString()}
					</span>
				</div>
				<div className="flex gap-3 text-xs font-medium">
					<span>{commentCount} bình luận</span>
					<span>{shares} chia sẻ</span>
				</div>
			</div>

			{/* Action buttons */}
			<div className="border-t border-slate-100 dark:border-zinc-800/80 mx-4" />
			<div className="px-2 py-1 flex items-center justify-around">
				<div className="relative flex-1">
					<Button
						variant="ghost"
						className={`w-full gap-2 hover:bg-slate-50 dark:hover:bg-zinc-800/50 rounded-lg ${
							selectedReaction
								? reactions.find(
										(r) => r.label === selectedReaction,
									)?.color
								: ""
						}`}
						onMouseEnter={() => setShowReactions(true)}
						onMouseLeave={() => setShowReactions(false)}
						onClick={handleLikeClick}
					>
						{selectedReaction ? (
							<span className="text-xl -mt-1">
								{
									reactions.find(
										(r) => r.label === selectedReaction,
									)?.emoji
								}
							</span>
						) : (
							<ThumbsUp className="w-5 h-5" />
						)}
						<span className="font-semibold text-sm">
							{selectedReaction || "Thích"}
						</span>
					</Button>

					{showReactions && (
						<div
							className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 backdrop-blur-md bg-white/90 dark:bg-zinc-900/90 border border-slate-100 dark:border-zinc-800 rounded-full shadow-lg p-1.5 flex gap-1.5 z-50"
							onMouseEnter={() => setShowReactions(true)}
							onMouseLeave={() => setShowReactions(false)}
						>
							{reactions.map((reaction) => (
								<button
									key={reaction.label}
									className="hover:scale-130 transition-transform w-10 h-10 rounded-full flex items-center justify-center hover:bg-slate-100 dark:hover:bg-zinc-800/80 text-2xl duration-200"
									onClick={() =>
										handleSelectReaction(reaction.label)
									}
									title={reaction.label}
								>
									{reaction.emoji}
								</button>
							))}
						</div>
					)}
				</div>

				<Button
					variant="ghost"
					className="flex-1 gap-2 hover:bg-slate-50 dark:hover:bg-zinc-800/50 rounded-lg text-muted-foreground hover:text-foreground"
					onClick={() => setShowComments(!showComments)}
				>
					<MessageCircle className="w-5 h-5" />
					<span className="font-semibold text-sm">Bình luận</span>
				</Button>
				<Button
					variant="ghost"
					className="flex-1 gap-2 hover:bg-slate-50 dark:hover:bg-zinc-800/50 rounded-lg text-muted-foreground hover:text-foreground"
					onClick={() => setShowShareModal(true)}
				>
					<Share2 className="w-5 h-5" />
					<span className="font-semibold text-sm">Chia sẻ</span>
				</Button>
			</div>

			{/* Comment section */}
			{showComments && (
				<div className="p-4 border-t border-slate-100 dark:border-zinc-800 bg-slate-50/30 dark:bg-zinc-900/10">
					<form
						onSubmit={handleAddComment}
						className="flex items-center gap-2 mb-4"
					>
						<Avatar className="w-8 h-8">
							<AvatarImage src="https://picsum.photos/seed/myavatar/100/100" />
							<AvatarFallback>U</AvatarFallback>
						</Avatar>
						<div className="relative flex-1 flex items-center">
							<input
								type="text"
								placeholder="Viết bình luận..."
								value={newCommentText}
								onChange={(e) =>
									setNewCommentText(e.target.value)
								}
								className="bg-slate-100 dark:bg-zinc-800/50 rounded-full pl-4 pr-10 py-2 w-full text-sm border-none focus:outline-none focus:ring-1 focus:ring-primary/20"
							/>
							<Button
								type="submit"
								variant="ghost"
								size="icon"
								disabled={!newCommentText.trim()}
								className="absolute right-1 w-8 h-8 rounded-full text-primary hover:bg-primary/10 disabled:opacity-30 disabled:hover:bg-transparent"
							>
								<Send className="w-4 h-4" />
							</Button>
						</div>
					</form>

					<div className="space-y-3.5 max-h-[300px] overflow-y-auto pr-1">
						{commentsList.map((comment) => (
							<div
								key={comment.id}
								className="flex items-start gap-2.5"
							>
								<Avatar className="w-8 h-8 mt-0.5">
									<AvatarImage src={comment.avatar} />
									<AvatarFallback>
										{comment.author[0]}
									</AvatarFallback>
								</Avatar>
								<div className="bg-slate-100 dark:bg-zinc-800/55 rounded-2xl px-3 py-2 max-w-[85%]">
									<p className="font-semibold text-xs text-foreground/80">
										{comment.author}
									</p>
									<p className="text-sm text-foreground/90 mt-0.5 leading-relaxed">
										{comment.text}
									</p>
								</div>
							</div>
						))}
					</div>
				</div>
			)}

			{/* Share modal */}
			{showShareModal && (
				<ShareModal onClose={() => setShowShareModal(false)} />
			)}
		</Card>
	);
}
