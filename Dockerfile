# Step 1: Use a base image with both Python and git
FROM python:3.9-slim

# Step 2: Install necessary packages including git, curl, and node
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Step 3: Install Node.js and npm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# Download and install Node.js:
RUN nvm install 22

# RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
#     && apt-get install -y nodejs \
#     && npm install -g npm@latest

# Step 4: Set the working directory
WORKDIR /app

# Step 5: Clone your git repository into a subdirectory
RUN git clone https://github.com/ssocolow/flare_insure.git

# Step 6: Install Node.js dependencies
COPY package.json package-lock.json* ./
RUN npm install --save-dev hardhat
RUN npm install express

# Step 7: Copy application files
COPY . .

# Step 8: Setup script handling
COPY setup.sh ./flare_insure/
RUN chmod +x ./flare_insure/setup.sh
WORKDIR /app/flare_insure  # Change to git repo directory
RUN ./setup.sh

# Step 9: Return to app directory and expose port
WORKDIR /app
EXPOSE 3003

# Step 10: Define the command to run the app
CMD ["node", "app.js"]
