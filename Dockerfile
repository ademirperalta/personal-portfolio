# ---- 1. Base image with Node
FROM node:20-alpine AS base
WORKDIR /app
ENV NEXT_TELEMETRY_DISABLED=1

# ---- 2. Install dependencies separately (cached)
FROM base AS deps
COPY package.json package-lock.json* yarn.lock* ./
RUN npm install --frozen-lockfile

# ---- 3. Build the Next/OpenNext bundle
FROM base AS builder
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build           # runs "next build"
# If you want to test the Cloudflare bundle locally
# RUN npx opennextjs-cloudflare build

# ---- 4. Lightweight runtime image
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/package.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
EXPOSE 3000
CMD ["npm", "start"]     # prod: next start

# ---- 5. Runtime for local *development* ----
FROM node:20-alpine AS dev
WORKDIR /app
ENV NODE_ENV=development
# bring in *all* node_modules so `next dev` exists
COPY --from=deps /app/node_modules ./node_modules
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]   # dev: next dev with hot-reload