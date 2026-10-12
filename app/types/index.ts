/**
 * Tea Dating Advice — Canonical Shared TypeScript Types
 * Defined per PRE_DEV_GUIDE Pillar 1 (Shared TypeScript Types).
 * All domain models, entity shapes, enums, and API interfaces.
 */

// --- Media & Photos ---
export interface Photo {
  id: string;
  url: string;
  position: number;
}

// --- Quick Status Notes / Stories ---
export interface StoryItem {
  id: string;
  userId?: string;
  author: string;
  name: string;
  authorPhotoUrl?: string;
  note: string;
  emoji?: string;
  isSelf?: boolean;
}

export interface QuickNoteInput {
  note: string;
  emoji?: string;
}

// --- Dating Dilemmas & Feed Posts ---
export type VerdictType = 'red' | 'green' | 'valid';

export interface FeedPost {
  id: string;
  title: string;
  category: string;
  question: string;
  mode: 'all' | 'spill' | 'advice' | string;
  author: string;
  authorId: string;
  authorHandle: string;
  authorRank?: string;
  authorFollowers?: number;
  authorPhotoUrl?: string;
  city: string;
  likeCount: number;
  commentCount: number;
  helpfulCount: number;
  likedByMe: boolean;
  followedByMe?: boolean;
  savedByMe?: boolean;
  redFlagCount?: number;
  greenFlagCount?: number;
  validCount?: number;
  userVote?: VerdictType | null;
  myVote?: VerdictType | null;
  topComment?: {
    author: string;
    text: string;
    helpfulCount: number;
  } | null;
  relation?: 'self' | 'matched' | 'liked' | 'none' | string;
  conversationId?: string;
  createdAt: string;
}

export interface CreatePostInput {
  title: string;
  category: string;
  question: string;
}

export interface FeedComment {
  id: string;
  postId?: string;
  userId: string;
  name: string;
  photoUrl?: string;
  advisorRank?: string;
  body: string;
  helpfulCount: number;
  isTopAdvice?: boolean;
  mine: boolean;
  createdAt: string;
}

// --- Advisors & Leaderboard ---
export interface AdvisorPerson {
  id: string;
  name: string;
  handle: string;
  photoUrl?: string;
  rank: string;
  bio: string;
  followersCount: number;
  followingCount: number;
  adviceGivenCount: number;
  helpfulPercent: number;
  isFollowing: boolean;
  recentAdviceQuote: string;
  city: string;
  specialty: string;
  postsCount?: number;
  upvotesCount?: number;
}

export interface ToggleFollowResult {
  isFollowing: boolean;
  followersCount: number;
}

// --- People & Discovery ---
export interface Person {
  id: string;
  name: string;
  handle?: string;
  age: number;
  gender?: string;
  city: string;
  distanceKm?: number;
  isNew?: boolean;
  online?: boolean;
  interests: string[];
  about: string;
  intent: string;
  matchPercent: number;
  photos: Photo[];
  photoUrl?: string;
  followersCount?: number;
  isFollowing?: boolean;
}

export type NearbyPerson = Person;

export interface MatchItem {
  id: string;
  conversationId: string;
  person: Person;
  createdAt: string;
}

export interface LikesSummary {
  received: number;
  matches: number;
  people: Person[];
}

// --- Conversations & Messaging ---
export interface ConversationItem {
  id: string;
  matchId?: string;
  peerId: string;
  name: string;
  handle?: string;
  photoUrl?: string;
  preview: string;
  time: string;
  lastMessageAt: string;
  unread?: boolean;
  requestStatus?: 'active' | 'request';
}

export interface ChatMessage {
  id: string;
  senderId: string;
  body: string;
  mine: boolean;
  reaction?: string;
  created_at: string;
}

export interface SendMessageInput {
  body: string;
}

// --- Activity Notifications ---
export type NotificationType = 'follow' | 'follow_request' | 'like' | 'advice_reply';

export interface NotificationItem {
  id: string;
  type: NotificationType;
  actorId?: string;
  actorName: string;
  actorHandle: string;
  actorPhotoUrl?: string;
  text: string;
  time: string;
  read: boolean;
  confirmed?: boolean;
  followedBack?: boolean;
  postId?: string;
  postSnippet?: string;
  postCategory?: string;
  section?: 'Today' | 'Earlier';
}

// --- User Profile & Authentication ---
export interface MyProfile {
  user_id: string;
  display_name: string;
  handle: string;
  gender: string | null;
  looking_for: string[];
  intent: string;
  birthday: string | null;
  age: number | null;
  city: string;
  country: string;
  about: string;
  interests: string[];
  lat: number | null;
  lng: number | null;
  min_age: number;
  max_age: number;
  max_distance_km: number;
  onboarding_complete: boolean;
  email: string;
  phone: string | null;
  has_password: boolean;
  photos: Photo[];
  postsCount: number;
  followersCount: number;
  followingCount: number;
  helpfulRating: number;
  rankTitle: string;
  specialty?: string;
  recentAdviceQuote?: string;
  adviceGivenCount?: number;
}

export type PatchProfileBody = Partial<{
  display_name: string;
  handle: string;
  gender: string;
  looking_for: string[];
  intent: string;
  birthday: string;
  city: string;
  country: string;
  about: string;
  interests: string[];
  specialty: string;
  recent_advice_quote: string;
  min_age: number;
  max_age: number;
  max_distance_km: number;
  lat: number;
  lng: number;
  complete_onboarding: boolean;
}>;

export interface AuthTokens {
  access_token: string;
  refresh_token: string;
  token_type?: string;
  expires_in?: number;
}

export interface AuthenticatedUser {
  id: string;
  email: string;
  name?: string;
  handle?: string;
  email_verified: boolean;
  created_at: string;
}

// --- API Envelopes & Utility Types ---
export interface PaginatedResponse<T> {
  items: T[];
  total: number;
  page: number;
  per_page: number;
  has_more: boolean;
}

export interface ApiError {
  status: number;
  code: string;
  message: string;
}
