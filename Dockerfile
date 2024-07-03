FROM node:lts-buster

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    ffmpeg \
    imagemagick \
    webp \
    screen && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the application's port
EXPOSE 5000

# Create a non-root user
RUN useradd -m myuser
USER myuser

# Start the application using screen
CMD ["screen", "-S", "terminal", "-dm", "node", "main.js"]
