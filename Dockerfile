# Stage 1: Build
FROM --platform=${BUILDPLATFORM} denoland/deno:2.0.4 AS builder

WORKDIR /deno-app

# Copy the application code
COPY main.ts deno.json deno.lock ./

# Compile the binary
RUN deno compile --output /app/main --allow-net main.ts

# Stage 2: Run
FROM gcr.io/distroless/cc

COPY --from=builder /app/main /

EXPOSE 8000

ENTRYPOINT ["/main"]