# Start with Node.js base image
FROM node:latest

# Set the working directory
WORKDIR /app

# Clone your git repository into a subdirectory
RUN git clone https://github.com/ssocolow/flare_insure.git

# Install Node.js dependencies
COPY package.json package-lock.json* ./
RUN npm install --save-dev hardhat
RUN npm install express

# Copy application files
COPY . .

# Setup script handling
COPY setup.sh ./flare_insure/
RUN chmod +x ./flare_insure/setup.sh
WORKDIR /app/flare_insure  # Change to git repo directory
RUN ./setup.sh

# Return to app directory and expose port
WORKDIR /app
EXPOSE 3003

# Define the command to run the app
CMD ["node", "app.js"]
